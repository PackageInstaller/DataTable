-- chunkname: @modules/logic/rouge/map/view/map/RougeMapLayerRightView.lua

module("modules.logic.rouge.map.view.map.RougeMapLayerRightView", package.seeall)

local RougeMapLayerRightView = class("RougeMapLayerRightView", BaseView)

function RougeMapLayerRightView:onInitView()
	self.goLayerRight = gohelper.findChild(self.viewGO, "#go_layer_right")
	self.simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#go_layer_right/RightBG2/#simage_newrightbg")
	self._gopic = gohelper.findChild(self.viewGO, "#go_layer_right/#go_pic")
	self.simagelayerbg = gohelper.findChildSingleImage(self.viewGO, "#go_layer_right/#go_pic/#simage_picbg")
	self.simagelayerpic = gohelper.findChildSingleImage(self.viewGO, "#go_layer_right/#go_pic/#simage_pic")
	self._txtChapterName = gohelper.findChildText(self.viewGO, "#go_layer_right/Title/#txt_ChapterName")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_layer_right/#txt_Desc")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layer_right/Title/#btn_next")
	self._btnLast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layer_right/Title/#btn_last")
	self._btnMove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_layer_right/#btn_MoveBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapLayerRightView:addEvents()
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnLast:AddClickListener(self._btnLastOnClick, self)
	self._btnMove:AddClickListener(self._btnMoveOnClick, self)
end

function RougeMapLayerRightView:removeEvents()
	self._btnNext:RemoveClickListener()
	self._btnLast:RemoveClickListener()
	self._btnMove:RemoveClickListener()
end

function RougeMapLayerRightView:_btnLastOnClick()
	if self.curSelectIndex <= 1 then
		return
	end

	self.curSelectIndex = self.curSelectIndex - 1

	self:changeSelectLayer()
end

function RougeMapLayerRightView:_btnNextOnClick()
	if self.curSelectIndex >= self.nextLayerLen then
		return
	end

	self.curSelectIndex = self.curSelectIndex + 1

	self:changeSelectLayer()
end

function RougeMapLayerRightView:changeSelectLayer()
	local layerId = self.nextLayerList[self.curSelectIndex]

	RougeMapModel.instance:updateSelectLayerId(layerId)
end

function RougeMapLayerRightView:_btnMoveOnClick()
	RougeRpc.instance:sendRougeLeaveMiddleLayerRequest(self.layerCo.id)
end

function RougeMapLayerRightView:_editableInitView()
	self.simagerightbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg2.png")
	self.simagelayerbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg3.png")

	self.goNextBtn = self._btnNext.gameObject
	self.goLastBtn = self._btnLast.gameObject
	self.layerAnimator = self.goLayerRight:GetComponent(gohelper.Type_Animator)

	self:hide()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self)
end

function RougeMapLayerRightView:onChangeMapInfo()
	local isPathSelect = RougeMapModel.instance:isPathSelect()

	if not isPathSelect then
		self:hide()

		return
	end

	self:initData()
end

function RougeMapLayerRightView:onSelectLayerChange(layerId)
	self.layerCo = lua_rouge_layer.configDict[layerId]

	self:updateSelectIndex()
	self.layerAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.runDelay(self.refresh, self, RougeMapEnum.WaitMapRightRefreshTime)
end

function RougeMapLayerRightView:onOpen()
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	self:initData()
end

function RougeMapLayerRightView:initData()
	self.nextLayerList = RougeMapModel.instance:getNextLayerList()
	self.nextLayerLen = #self.nextLayerList

	local selectLayerId = RougeMapModel.instance:getSelectLayerId()

	self.layerCo = lua_rouge_layer.configDict[selectLayerId]

	self:updateSelectIndex()
end

function RougeMapLayerRightView:updateSelectIndex()
	self.curSelectIndex = 1

	for index, nextLayerId in ipairs(self.nextLayerList) do
		if self.layerCo.id == nextLayerId then
			self.curSelectIndex = index
		end
	end
end

function RougeMapLayerRightView:onPathSelectMapFocusDone()
	self:refresh()
end

function RougeMapLayerRightView:refresh()
	self:show()
	self:refreshLayerInfo()
	self:refreshArrow()
	self:refreshImage()
end

function RougeMapLayerRightView:refreshLayerInfo()
	self._txtChapterName.text = self.layerCo.name
	self._txtDesc.text = self.layerCo.desc
end

function RougeMapLayerRightView:refreshArrow()
	gohelper.setActive(self.goNextBtn, self.curSelectIndex < self.nextLayerLen)
	gohelper.setActive(self.goLastBtn, self.curSelectIndex > 1)
end

function RougeMapLayerRightView:refreshImage()
	local res = self.layerCo.iconRes

	if string.nilorempty(res) then
		return
	end

	local path = string.format("singlebg/rouge/mapdetail/%s.png", res)

	self.simagelayerpic:LoadImage(path)
end

function RougeMapLayerRightView:show()
	gohelper.setActive(self.goLayerRight, true)
end

function RougeMapLayerRightView:hide()
	gohelper.setActive(self.goLayerRight, false)
end

function RougeMapLayerRightView:onDestroyView()
	self.simagerightbg:UnLoadImage()
	self.simagelayerbg:UnLoadImage()
	self.simagelayerpic:UnLoadImage()
	TaskDispatcher.cancelTask(self.refresh, self)
end

return RougeMapLayerRightView
