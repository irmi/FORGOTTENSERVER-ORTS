local config = {
	[3206] = Position(32359, 32901, 7),
	[3207] = Position(32340, 32538, 7),
	[3208] = Position(32472, 32869, 7),
	[3209] = Position(32415, 32916, 7),
	[3210] = Position(32490, 32979, 7),
	[3211] = Position(32440, 32971, 7),
	[3212] = Position(32527, 32951, 7),
	[3213] = Position(32523, 32923, 7)
}

function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(config[item.uid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end