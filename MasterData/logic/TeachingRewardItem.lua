-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingRewardItem.lua

module("logic.extensions.teachingdungeon.TeachingRewardItem", package.seeall)

local TeachingRewardItem = class("TeachingRewardItem")

function TeachingRewardItem.AddOnce(go)
	return GameUtil.AddLuaOnce(go, TeachingRewardItem)
end

function TeachingRewardItem.Remove(go)
	local obj = GameUtil.GetLua(go, TeachingRewardItem)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, TeachingRewardItem)
end

function TeachingRewardItem:ctor(go)
	self.model = TeachingDungeonModel.instance
	self.mainGO = go.gameObject

	self:buildUI()
	self:initEvent()
end

function TeachingRewardItem:dispose()
	return
end

function TeachingRewardItem:OnDestroy()
	self:onExit()
	self:unbindEvent()
end

function TeachingRewardItem:unbindEvent()
	return
end

function TeachingRewardItem:initEvent()
	return
end

function TeachingRewardItem:onExit()
	MaterialMgr.resetAll(self.itemCon)
end

function TeachingRewardItem:buildUI()
	self.itemCon = goutil.findChild(self.mainGO, "con")
	self.goYlq = goutil.findChild(self.mainGO, "imgYlq")
end

function TeachingRewardItem:setData(cfg, isPerfect)
	local stageId = self.model:getCurrStageId()

	GameUtil.SetActive(self.goYlq, isPerfect and self.model:isStagePerfectPass(stageId) or self.model:isStagePass(stageId))

	local proxy = MaterialMgr.setCellByCfg(cfg, self.itemCon)
end

return TeachingRewardItem
