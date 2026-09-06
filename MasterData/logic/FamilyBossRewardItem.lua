-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossRewardItem.lua

module("logic.extensions.family.view.FamilyBossRewardItem", package.seeall)

local FamilyBossRewardItem = class("FamilyBossRewardItem")

function FamilyBossRewardItem:ctor(go)
	self.mainGO = go.gameObject

	self:buildUI()
	self:initEvent()
end

function FamilyBossRewardItem:OnDestroy()
	self:onExit()
	self:unbindEvent()
end

function FamilyBossRewardItem:unbindEvent()
	return
end

function FamilyBossRewardItem:initEvent()
	return
end

function FamilyBossRewardItem:buildUI()
	return
end

function FamilyBossRewardItem:onExit()
	MaterialMgr.resetAll(self.mainGO)
end

function FamilyBossRewardItem:setData(data, index)
	MaterialMgr.setCellByCfg(data, self.mainGO)

	local x = (index - 1) % 3
	local y = math.ceil(index / 3) - 1

	GameUtil.setLocalPos(self.mainGO, x * 110 + 25, -y * 110 - 25)
end

return FamilyBossRewardItem
