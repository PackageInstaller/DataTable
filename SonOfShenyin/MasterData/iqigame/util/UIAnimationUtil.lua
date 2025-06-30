-- chunkname: @IQIGame\\Util\\UIAnimationUtil.lua

UIAnimationUtil = {}

local this = UIAnimationUtil

function this.Init()
	this.currentPlayAnimationList = {}
end

function this.Dispose()
	this.Init()
end

function this.Play(gameObject, name, onStartEvent, onCompleteEvent, isSolo)
	if isSolo then
		for _, v in pairs(this.currentPlayAnimationList) do
			LuaUtility.CompleteAnimation(v.gameObject, v.name)
		end

		this.currentPlayAnimationList = {}

		this._PlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
	else
		this._PlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
	end
end

function this._PlayAnimation(gameObject, name, onStartEvent, onCompleteEvent)
	local data = {}

	data.gameObject = gameObject
	data.name = name

	table.insert(this.currentPlayAnimationList, data)
	LuaUtility.PlayAnimation(gameObject, name, onStartEvent, function()
		table.removeElement(this.currentPlayAnimationList, data)

		if onCompleteEvent then
			onCompleteEvent()
		end
	end)
end
