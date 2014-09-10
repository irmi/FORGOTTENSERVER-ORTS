local config = {
	{position = Position(33268, 31833, 10), itemid = 8304, toPosition = Position(33268, 31833, 12)},
	{position = Position(33268, 31838, 10), itemid = 8305, toPosition = Position(33267, 31838, 12)},
	{position = Position(33270, 31835, 10), itemid = 8300, toPosition = Position(33270, 31835, 12)},
	{position = Position(33266, 31835, 10), itemid = 8306, toPosition = Position(33265, 31835, 12)}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.itemid ~= 1945 then
		Item(item.uid):transform(1945)
		return true
	end

	local player = Player(cid)
	if player:getPosition() ~= Position(33270, 31835, 10) then
		return false
	end

	local spectators = Game.getSpectators(Position(33268, 31836, 12), false, true, 30, 30, 30, 30)
	if #spectators > 0 or (Game.getStorageValue(10004) or -1) > 0 then
		player:say('Wait for the current team to exit.', TALKTYPE_MONSTER_SAY, false, 0, Position(33268, 31835, 10))
		return true
	end

	local players = {}
	for i = 1, #config do
		local creature = Tile(config[i].position):getTopCreature()
		if not creature or not creature:isPlayer() then
			player:say('You need one player of each vocation having completed the Elemental Spheres quest and also carrying the elemental rare item.', TALKTYPE_MONSTER_SAY, false, 0, Position(33268, 31835, 10))
			return true
		end

		local vocationId = getBaseVocation(creature:getVocation():getId())
		if vocationId ~= i or creature:getItemCount(config[i].itemid) < 1 or creature:getStorageValue(10000) < 2 then
			player:say('You need one player of each vocation having completed the Elemental Spheres quest and also carrying the elemental rare item.', TALKTYPE_MONSTER_SAY, false, 0, Position(33268, 31835, 10))
			return true
		end

		table.insert(players, creature)
	end

	for i = 1, #players do
		players[i]:teleportTo(config[i].toPosition)
		config[i].position:sendMagicEffect(CONST_ME_TELEPORT)
	end

	for i = 1, #config do
		config[i].toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end

	Item(item.uid):transform(item.itemid + 1)
	return true
end
