-- chunkname: @modules/logic/rouge/map/view/nextlayer/RougeNextLayerView.lua

module("modules.logic.rouge.map.view.nextlayer.RougeNextLayerView", package.seeall)

local RougeNextLayerView = class("RougeNextLayerView", BaseView)

function RougeNextLayerView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagetitlebg = gohelper.findChildSingleImage(self.viewGO, "#simage_titlebg")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeNextLayerView:addEvents()
	return
end

function RougeNextLayerView:removeEvents()
	return
end

function RougeNextLayerView:_editableInitView()
	self._simagefullbg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg.png")
	self._simagetitlebg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg2.png")
	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onLoadMapDone, self.onLoadMapDone, self)
end

function RougeNextLayerView:onLoadMapDone()
	self.loadDone = true

	self:closeView()
end

function RougeNextLayerView:closeView()
	if not self.loadDone or not self.overMinTime then
		return
	end

	self:closeThis()
end

function RougeNextLayerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchNormalLayer)

	self.loadDone = not RougeMapModel.instance:checkIsLoading()
	self.overMinTime = false

	local layerId = self.viewParam
	local layerCo = lua_rouge_layer.configDict[layerId]

	self._txttitle.text = layerCo.name
	self._txtdec.text = layerCo.crossDesc

	TaskDispatcher.runDelay(self.onMinTimeDone, self, RougeMapEnum.SwitchLayerMinDuration)
	TaskDispatcher.runDelay(self.onMaxTimeDone, self, RougeMapEnum.SwitchLayerMaxDuration)
end

function RougeNextLayerView:onMinTimeDone()
	self.overMinTime = true

	self:closeView()
end

function RougeNextLayerView:onMaxTimeDone()
	self:closeThis()
end

function RougeNextLayerView:onDestroyView()
	TaskDispatcher.cancelTask(self.onMinTimeDone, self)
	TaskDispatcher.cancelTask(self.onMaxTimeDone, self)
	self._simagefullbg:UnLoadImage()
	self._simagetitlebg:UnLoadImage()
end

return RougeNextLayerView
