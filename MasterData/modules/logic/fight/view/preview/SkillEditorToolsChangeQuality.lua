-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolsChangeQuality.lua

module("modules.logic.fight.view.preview.SkillEditorToolsChangeQuality", package.seeall)

local SkillEditorToolsChangeQuality = class("SkillEditorToolsChangeQuality", BaseViewExtended)

function SkillEditorToolsChangeQuality:onInitView()
	return
end

function SkillEditorToolsChangeQuality:addEvents()
	return
end

function SkillEditorToolsChangeQuality:_editableInitView()
	return
end

function SkillEditorToolsChangeQuality:onRefreshViewParam()
	return
end

function SkillEditorToolsChangeQuality:_onBtnClick()
	self:getParentView():hideToolsBtnList()
	gohelper.setActive(self._btn, true)
end

function SkillEditorToolsChangeQuality:onOpen()
	self:getParentView():addToolBtn("画质", self._onBtnClick, self)

	self._btn = self:getParentView():addToolViewObj("画质")
	self._item = gohelper.findChild(self._btn, "variant")

	self:_showData()
end

function SkillEditorToolsChangeQuality:_showData()
	local list = {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}

	self:com_createObjList(self._onItemShow, list, self._btn, self._item)
end

function SkillEditorToolsChangeQuality:_onItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "Text")
	local str = ""

	if data == ModuleEnum.Performance.High then
		str = "高"
	elseif data == ModuleEnum.Performance.Middle then
		str = "中"
	elseif data == ModuleEnum.Performance.Low then
		str = "低"
	end

	text.text = str

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onItemClick, self, data)
end

function SkillEditorToolsChangeQuality:_onItemClick(data)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(data)
	FightEffectPool.dispose()
end

function SkillEditorToolsChangeQuality:onClose()
	return
end

function SkillEditorToolsChangeQuality:onDestroyView()
	return
end

return SkillEditorToolsChangeQuality
