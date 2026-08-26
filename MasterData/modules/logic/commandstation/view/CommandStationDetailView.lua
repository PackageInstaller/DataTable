-- chunkname: @modules/logic/commandstation/view/CommandStationDetailView.lua

module("modules.logic.commandstation.view.CommandStationDetailView", package.seeall)

local CommandStationDetailView = class("CommandStationDetailView", BaseView)

function CommandStationDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtRole = gohelper.findChildText(self.viewGO, "Root/#txt_Role")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/#txt_Title")
	self._goItem = gohelper.findChild(self.viewGO, "Root/scroll_Head/Viewport/Content/#go_Item")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "Root/scroll_Head/Viewport/Content/#go_Item/#image_career")
	self._goempty = gohelper.findChild(self.viewGO, "Root/#go_empty")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/Scroll View/Viewport/#txt_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CommandStationDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CommandStationDetailView:_btncloseOnClick()
	self:closeThis()
end

function CommandStationDetailView:_editableInitView()
	gohelper.setActive(self._goItem, false)
	gohelper.setActive(self._goempty, false)
end

function CommandStationDetailView:onUpdateParam()
	return
end

function CommandStationDetailView:_getCharList(t)
	local list = {}

	for i, chaEventId in ipairs(t) do
		local eventConfig = lua_copost_character_event.configDict[chaEventId]

		if eventConfig.chaId ~= 0 then
			table.insert(list, eventConfig.chaId)
		end

		if #eventConfig.chasId > 0 then
			for _, chaId in ipairs(eventConfig.chasId) do
				table.insert(list, chaId)
			end
		end
	end

	return list
end

function CommandStationDetailView:onOpen()
	local id = self.viewParam.timeId
	local config = lua_copost_time_point_event.configDict[id]
	local textId = config and config.allTextId
	local textConfig = textId and lua_copost_event_text.configDict[textId]

	self._txtDescr.text = textConfig and textConfig.text

	if config and #config.chaId > 0 then
		local list = config.chaId

		gohelper.CreateObjList(self, self._onItemShow2, list, self._goItem.transform.parent.gameObject, self._goItem)

		return
	end

	local chaEventId = config and config.chaEventId

	if chaEventId and #chaEventId ~= 0 then
		local list = self:_getCharList(chaEventId)

		gohelper.CreateObjList(self, self._onItemShow, list, self._goItem.transform.parent.gameObject, self._goItem)
	else
		gohelper.setActive(self._goempty, true)
	end
end

function CommandStationDetailView:_onItemShow(obj, chaId, index)
	local singleImage = gohelper.findChildSingleImage(obj, "image_Icon")
	local chaConfig = chaId and lua_copost_character.configDict[chaId]

	if chaConfig then
		singleImage:LoadImage(ResUrl.getHeadIconSmall(chaConfig.chaPicture))
	end
end

function CommandStationDetailView:_onItemShow2(obj, chaId, index)
	local singleImage = gohelper.findChildSingleImage(obj, "image_Icon")

	singleImage:LoadImage(ResUrl.getHeadIconSmall(chaId))
end

function CommandStationDetailView:onClose()
	return
end

function CommandStationDetailView:onDestroyView()
	return
end

return CommandStationDetailView
