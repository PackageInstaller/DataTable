-- chunkname: @modules/logic/fight/view/FightStatView.lua

module("modules.logic.fight.view.FightStatView", package.seeall)

local FightStatView = class("FightStatView", BaseView)

function FightStatView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._btnclosebg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebg")
	self._simagebgicon1 = gohelper.findChildSingleImage(self.viewGO, "frame/#simage_bgicon1")
	self._simagebgicon2 = gohelper.findChildSingleImage(self.viewGO, "frame/#simage_bgicon2")
	self._btndata = gohelper.findChildButtonWithAudio(self.viewGO, "switch/#btn_data")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "switch/#btn_skill")
	self._godataselect = gohelper.findChild(self.viewGO, "switch/#btn_data/go_select")
	self._godatanormal = gohelper.findChild(self.viewGO, "switch/#btn_data/go_normal")
	self._goskillselect = gohelper.findChild(self.viewGO, "switch/#btn_skill/go_select")
	self._goskillnormal = gohelper.findChild(self.viewGO, "switch/#btn_skill/go_normal")
	self._godatatxt = gohelper.findChild(self.viewGO, "view/#go_datatxt")
	self._goskilltxt = gohelper.findChild(self.viewGO, "view/#go_skilltxt")
end

function FightStatView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnclosebg:AddClickListener(self.closeThis, self)
	self._btndata:AddClickListener(self._btnDataOnClick, self)
	self._btnskill:AddClickListener(self._btnSkillOnClick, self)
end

function FightStatView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnclosebg:RemoveClickListener()
	self._btndata:RemoveClickListener()
	self._btnskill:RemoveClickListener()
end

function FightStatView:onOpen()
	self._simagebgicon1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebgicon2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function FightStatView:_btnDataOnClick()
	if self._statType == FightEnum.FightStatType.DataView then
		return
	end

	self._statType = FightEnum.FightStatType.DataView

	self:_refreshUI()
end

function FightStatView:_btnSkillOnClick()
	if self._statType == FightEnum.FightStatType.SkillView then
		return
	end

	self._statType = FightEnum.FightStatType.SkillView

	self:_refreshUI()
end

function FightStatView:_refreshUI()
	gohelper.setActive(self._godataselect, self._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(self._godatanormal, self._statType ~= FightEnum.FightStatType.DataView)
	gohelper.setActive(self._goskillselect, self._statType == FightEnum.FightStatType.SkillView)
	gohelper.setActive(self._goskillnormal, self._statType ~= FightEnum.FightStatType.SkillView)
	gohelper.setActive(self._godatatxt, self._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(self._goskilltxt, self._statType == FightEnum.FightStatType.SkillView)
	FightController.instance:dispatchEvent(FightEvent.SwitchInfoState, self._statType)
end

function FightStatView:getStatType()
	return self._statType
end

function FightStatView:onCloseFinish()
	return
end

function FightStatView:onDestroyView()
	self._simagebgicon1:UnLoadImage()
	self._simagebgicon2:UnLoadImage()
end

function FightStatView:onClickModalMask()
	self:closeThis()
end

return FightStatView
