-- chunkname: @modules/logic/fight/playback/FightPlayBackItem.lua

module("modules.logic.fight.playback.FightPlayBackItem", package.seeall)

local FightPlayBackItem = class("FightPlayBackItem")

function FightPlayBackItem:init(fullFilePath)
	self.filePath = fullFilePath
end

function FightPlayBackItem:startPlay()
	return
end

function FightPlayBackItem:stopPlay()
	return
end

return FightPlayBackItem
