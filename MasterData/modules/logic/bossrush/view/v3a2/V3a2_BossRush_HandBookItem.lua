-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_HandBookItem.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_HandBookItem", package.seeall)

local V3a2_BossRush_HandBookItem = class("V3a2_BossRush_HandBookItem", ListScrollCellExtend)

function V3a2_BossRush_HandBookItem:onInitView()
	self._goSelectedBG = gohelper.findChild(self.viewGO, "#go_SelectedBG")
	self._simageboss = gohelper.findChildSingleImage(self.viewGO, "#simage_boss")
	self._imageboss = gohelper.findChildImage(self.viewGO, "#simage_boss")
	self._txtName = gohelper.findChildText(self.viewGO, "#txt_Name")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_HandBookItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a2_BossRush_HandBookItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a2_BossRush_HandBookItem:_btnclickOnClick()
	V3a2_BossRush_HandBookListModel.instance:onSelect(self.mo)
end

function V3a2_BossRush_HandBookItem:_editableInitView()
	self._imageBG = gohelper.findChildImage(self.viewGO, "bg")
end

function V3a2_BossRush_HandBookItem:onUpdateMO(mo)
	self.mo = mo

	local config = mo.config

	self._simageboss:LoadImage(ResUrl.getBossRushHandbookSinglebg(config.galleryBg))

	self._txtName.text = mo:getBossName()

	ZProj.UGUIHelper.SetGrayscale(self._simageboss.gameObject, not mo.haveFight)
	ZProj.UGUIHelper.SetGrayscale(self._imageBG.gameObject, not mo.haveFight)

	if mo.haveFight then
		self._imageBG.color = Color.white or GameUtil.parseColor("#969696")
	end

	gohelper.setActive(self._goLocked, not mo.haveFight)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.BossRushHankBookBoss, mo:getBossType())
	self:refreshSelect()
end

function V3a2_BossRush_HandBookItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V3a2_BossRush_HandBookItem:refreshSelect()
	local isSelect = self:_isSelect()

	gohelper.setActive(self._goselect, isSelect)
end

function V3a2_BossRush_HandBookItem:_isSelect()
	local curSelect = V3a2_BossRush_HandBookListModel.instance:getSelectMo()

	if not curSelect then
		return false
	end

	return curSelect.config.type == self.mo.config.type
end

function V3a2_BossRush_HandBookItem:onDestroyView()
	return
end

return V3a2_BossRush_HandBookItem
