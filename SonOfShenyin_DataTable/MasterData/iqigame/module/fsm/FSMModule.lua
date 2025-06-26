-- chunkname: @IQIGame\\Module\\FSM\\FSMModule.lua

FSMModule = {}

local this = FSMModule
local rpgActorFsm = require("IQIGame/Scene/Home/FSM/RPGActorFSM")

function this.Init()
	this.fsmArray = {}

	Initialization.AddUpdateFunc(this.Update)
end

function this.ShutDown()
	return
end

function this.Update()
	if not this.fsmArray then
		return
	end

	local fsmCount = #this.fsmArray

	if fsmCount <= 0 then
		return
	end

	for i = 1, fsmCount do
		this.fsmArray[i]:Update()
	end
end

function this.CreateFsm(fsmType, params)
	local fsm

	if fsmType == Constant.FSMType.RPGActorFSM then
		fsm = rpgActorFsm(params.actor)
	end

	if not fsm then
		return
	end

	table.insert(this.fsmArray, fsm)

	return fsm
end

function this.RemoveFsm(fsm)
	local len = #this.fsmArray

	for i = 1, len do
		if this.fsmArray[i] == fsm then
			table.remove(this.fsmArray, i)
		end
	end
end
