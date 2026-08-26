-- chunkname: @modules/logic/rouge/dlc/103/view/RougeMapView_1_103.lua

module("modules.logic.rouge.dlc.103.view.RougeMapView_1_103", package.seeall)

local RougeMapView_1_103 = class("RougeMapView_1_103", BaseViewExtended)

function RougeMapView_1_103:onInitView()
	self._godistotrule = gohelper.findChild(self.viewGO, "Left/#go_distortrule")
	self._godistotrule2 = gohelper.findChild(self.viewGO, "#go_layer_right/#go_rougedistortrule")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapView_1_103:onOpen()
	self:openSubView(RougeMapAttributeComp, nil, self._godistotrule)
	self:openSubView(RougeMapBossCollectionComp, nil, self._godistotrule2)
end

function RougeMapView_1_103:onClose()
	return
end

return RougeMapView_1_103
