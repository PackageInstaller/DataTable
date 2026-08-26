-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventSmallNpcItem.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventSmallNpcItem", package.seeall)

local SurvivalMonsterEventSmallNpcItem = class("SurvivalMonsterEventSmallNpcItem", ListScrollCellExtend)

function SurvivalMonsterEventSmallNpcItem:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#go_has/#simage_hero")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalMonsterEventSmallNpcItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function SurvivalMonsterEventSmallNpcItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function SurvivalMonsterEventSmallNpcItem:_btnclickOnClick()
	if not self._isCanEnter then
		GameFacade.showToast(ToastEnum.SurvivalBossDotSelectNpc)

		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalNpcStationView)
end

function SurvivalMonsterEventSmallNpcItem:updateItem(npcId)
	self._npcId = npcId

	gohelper.setActive(self._goempty, npcId == nil)
	gohelper.setActive(self._gohas, npcId ~= nil)

	if self._npcId then
		local npcCo = SurvivalConfig.instance:getNpcConfig(self._npcId)

		if npcCo then
			local path = ResUrl.getSurvivalNpcIcon(npcCo.smallIcon)

			self._simagehero:LoadImage(path)
		end
	end

	gohelper.setActive(self._goempty, self._showEmpty)
end

function SurvivalMonsterEventSmallNpcItem:setIsCanEnterSelect(status)
	self._isCanEnter = status
end

function SurvivalMonsterEventSmallNpcItem:setNeedShowEmpty(showEmpty)
	self._showEmpty = showEmpty
end

return SurvivalMonsterEventSmallNpcItem
