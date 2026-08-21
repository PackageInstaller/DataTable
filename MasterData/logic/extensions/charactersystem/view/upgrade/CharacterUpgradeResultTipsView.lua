-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/upgrade/CharacterUpgradeResultTipsView.lua

module("logic.extensions.charactersystem.view.upgrade.CharacterUpgradeResultTipsView", package.seeall)

local M = class("CharacterUpgradeResultTipsView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtnByPath("common_full_tips_bg/clickExit")

	goutil.setActive(self._btnReturn.gameObject, false)

	self._level1Txt = self:getText("character_upgrade_view_copy_-887920709")
	self._level2Txt = self:getText("character_upgrade_view_copy_342473912")
	self._hp1Txt = self:getText("character_upgrade_view_copy_1891259271")
	self._hp2Txt = self:getText("character_upgrade_view_copy_-1052831458")
	self._attack1Txt = self:getText("character_upgrade_view_copy_-1627580068")
	self._attack2Txt = self:getText("character_upgrade_view_copy_-2096467241")
	self._def1Txt = self:getText("character_upgrade_view_copy_-1626259100")
	self._def2Txt = self:getText("character_upgrade_view_copy_867282979")
	self._attackMag1Txt = self:getText("character_upgrade_view_copy_-42998125")
	self._attackMag2Txt = self:getText("character_upgrade_view_copy_-810476128")
	self._defMag1Txt = self:getText("character_upgrade_view_copy_-2034604974")
	self._defMag2Txt = self:getText("character_upgrade_view_copy_1476842832")
	self._afflatus1Txt = self:getText("character_upgrade_view_copy_-1219030428")
	self._afflatus2Txt = self:getText("character_upgrade_view_copy_-1729057174")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getOpenParam()

	self._heroDataBefore = param[1]
	self._heroDataAfter = param[2]

	self:_refreshView()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self:setEvent(false)
	self._guiAnimation:StopTimelineAni()
	GlobalDispatcher:dispatchEvent(EventType.UPGRADE_ANIM_FINISH)
end

function M:onExitFinished()
	PlayerAttributeGainTipsController.instance:unfreeze("upgrade")
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickReturn()
	self:close()
end

function M:_refreshView()
	self._level1Txt.text = string.format("%s", self._heroDataBefore.level)
	self._level2Txt.text = string.format("%s", self._heroDataAfter:getLevel())
	self._hp1Txt.text = self._heroDataBefore.hp
	self._hp2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	self._attack1Txt.text = self._heroDataBefore.attack
	self._attack2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.ATK_PHY)
	self._def1Txt.text = self._heroDataBefore.def
	self._def2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.DEF_PHY)
	self._attackMag1Txt.text = self._heroDataBefore.atkMag
	self._attackMag2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.ATK_MAG)
	self._defMag1Txt.text = self._heroDataBefore.defMag
	self._defMag2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.DEF_MAG)
	self._afflatus1Txt.text = self._heroDataBefore.afflatus
	self._afflatus2Txt.text = self._heroDataAfter:getAttribute(BattleExtension_pb.Attribute.INSPIRATION)
end

return M
