-- chunkname: @modules/logic/survival/view/shelter/SurvivalNpcHeadItem.lua

module("modules.logic.survival.view.shelter.SurvivalNpcHeadItem", package.seeall)

local SurvivalNpcHeadItem = class("SurvivalNpcHeadItem", LuaCompBase)

function SurvivalNpcHeadItem:ctor()
	return
end

function SurvivalNpcHeadItem:init(viewGO)
	self.viewGO = viewGO
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._goput = gohelper.findChild(self.viewGO, "#go_has/#go_put")
	self._simage_icon = gohelper.findChildSingleImage(self.viewGO, "#go_has/go_icon/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_has/#txt_name")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/#btn_remove")
end

function SurvivalNpcHeadItem:onStart()
	return
end

function SurvivalNpcHeadItem:addEventListeners()
	self.addClickCb(self, self._btnclick, self.onClickBtnClick, self)
	self.addClickCb(self, self._btnremove, self.onClickBtnRemove, self)
end

function SurvivalNpcHeadItem:removeEventListeners()
	return
end

function SurvivalNpcHeadItem:onDestroy()
	return
end

function SurvivalNpcHeadItem:onClickBtnClick()
	return
end

function SurvivalNpcHeadItem:onClickBtnRemove()
	if self.onClickBtnRemoveCallBack then
		self.onClickBtnRemoveCallBack(self.onClickContext, self)
	end
end

function SurvivalNpcHeadItem:setData(param)
	local oldNpcId = self.npcId

	self.pos = param.pos
	self.isFirst = param.isFirst
	self.npcId = param.npcId
	self.isSelect = param.isSelect or false
	self.isPlayPutEffect = param.isPlayPutEffect or false
	self.isShowBtnRemove = param.isShowBtnRemove or false
	self.onClickBtnRemoveCallBack = param.onClickBtnRemoveCallBack
	self.onClickContext = param.onClickContext

	gohelper.setActive(self._goSelected, self.isSelect)

	if not self.npcId then
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self._gohas, false)

		return
	end

	if self.isPlayPutEffect and not self.isFirst and self.npcId and self.npcId ~= oldNpcId then
		self:playPutEffect()
	end

	self.config = SurvivalConfig.instance:getNpcConfig(self.npcId)

	gohelper.setActive(self._btnremove, self.isShowBtnRemove)
	gohelper.setActive(self._goempty, false)
	gohelper.setActive(self._gohas, true)

	local path = ResUrl.getSurvivalNpcIcon(self.config.smallIcon)

	self._simage_icon:LoadImage(path)

	self._txtname.text = self.config.name
end

function SurvivalNpcHeadItem:playPutEffect()
	gohelper.setActive(self._goput, false)
	gohelper.setActive(self._goput, true)
end

return SurvivalNpcHeadItem
