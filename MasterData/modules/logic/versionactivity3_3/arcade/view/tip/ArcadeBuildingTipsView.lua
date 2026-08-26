-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeBuildingTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeBuildingTipsView", package.seeall)

local ArcadeBuildingTipsView = class("ArcadeBuildingTipsView", ArcadeTipsChildViewBase)

function ArcadeBuildingTipsView:init(go)
	self.viewGO = go
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "building/#scroll_building")
	self._gobuildingitem = gohelper.findChild(self.viewGO, "building/#scroll_building/viewport/content/#go_buildingitem")
	self._gobtn = gohelper.findChild(self.viewGO, "building/#scroll_building/viewport/content/#go_btn")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "building/#scroll_building/viewport/content/#go_btn/#btn_enter", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeBuildingTipsView:addEventListeners()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function ArcadeBuildingTipsView:removeEventListeners()
	self._btnenter:RemoveClickListener()
end

function ArcadeBuildingTipsView:_btnenterOnClick()
	if self._tipView then
		self._tipView:closeThis()
	end

	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnMoveToInteractive, self._buildingId)
end

function ArcadeBuildingTipsView:_editableInitView()
	ArcadeBuildingTipsView.super._editableInitView(self)

	self._items = self:getUserDataTb_()
	self._txtname = gohelper.findChildText(self._gobuildingitem, "title/txt_name")
	self._txtdec = gohelper.findChildText(self._gobuildingitem, "txt_desc")
end

function ArcadeBuildingTipsView:onUpdateMO(mo, tipview)
	self._buildingId = mo.buildingId

	ArcadeBuildingTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeBuildingTipsView:isPlayOpenAnim()
	return not self._buildingId or self._buildingId ~= self._mo.buildingId or self._isChange
end

function ArcadeBuildingTipsView:refreshView()
	if not self._buildingId then
		return
	end

	local mo = ArcadeHallModel.instance:getInteractiveMO(self._buildingId)
	local param = ArcadeHallEnum.LevelScene[self._buildingId]
	local finishLevelCount = ArcadeOutSizeModel.instance:getFinishLevelCount(param and param.Level)

	self._txtname.text = mo.co.name or ""
	self._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(mo.co.desc, finishLevelCount) or ""
end

function ArcadeBuildingTipsView:onDestroy()
	return
end

return ArcadeBuildingTipsView
