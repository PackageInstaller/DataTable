-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaTalkView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTalkView", package.seeall)

local TianShiNaNaTalkView = class("TianShiNaNaTalkView", BaseView)

function TianShiNaNaTalkView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._rootTrans = gohelper.findChild(self.viewGO, "root").transform
	self._desc = gohelper.findChildTextMesh(self.viewGO, "root/Scroll View/Viewport/Content/txt_talk")
	self._headIcon = gohelper.findChildSingleImage(self.viewGO, "root/Head/#simage_Head")
end

function TianShiNaNaTalkView:addEvents()
	self._btnclose:AddClickListener(self._onClickNext, self)
end

function TianShiNaNaTalkView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function TianShiNaNaTalkView:onOpen()
	self._steps = self.viewParam
	self._stepIndex = 0

	self:_nextStep()
end

function TianShiNaNaTalkView:_onClickNext()
	local totalLen = #self._charArr

	if totalLen > 5 and self._curShowCount < 5 then
		return
	end

	if totalLen == self._curShowCount then
		self:_nextStep()
	else
		self._curShowCount = totalLen - 1

		self:_showNextChar()
		TaskDispatcher.cancelTask(self._showNextChar, self)
	end
end

function TianShiNaNaTalkView:_nextStep()
	self._stepIndex = self._stepIndex + 1

	local curStepCo = self._steps[self._stepIndex]

	if not curStepCo then
		self:closeThis()

		return
	end

	local entity = TianShiNaNaEntityMgr.instance:getEntity(curStepCo.interactId)

	if not entity then
		logError("对话" .. curStepCo.id .. "找不到元件" .. curStepCo.interactId)
		self:closeThis()

		return
	end

	local worldPos = entity:getWorldPos()
	local uiCamera = CameraMgr.instance:getUICamera()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local v2Pos = recthelper.worldPosToAnchorPos(worldPos, self.viewGO.transform, uiCamera, mainCamera)

	recthelper.setAnchor(self._rootTrans, v2Pos.x, v2Pos.y + 180)

	self._curShowCount = 0
	self._charArr = GameUtil.getUCharArrWithoutRichTxt(curStepCo.content)

	if not string.nilorempty(curStepCo.icon) then
		self._curHeadIcon = curStepCo.icon
	end

	if self._curHeadIcon then
		self._headIcon:LoadImage(ResUrl.getHeadIconSmall(self._curHeadIcon))
	end

	if #self._charArr <= 1 then
		self._desc.text = ""

		recthelper.setHeight(self._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(self._showNextChar, self, 0.05, #self._charArr - 1)
	self:_showNextChar()
end

function TianShiNaNaTalkView:_showNextChar()
	self._curShowCount = self._curShowCount + 1
	self._desc.text = table.concat(self._charArr, "", 1, self._curShowCount)

	local preferredHeight = self._desc.preferredHeight

	recthelper.setHeight(self._rootTrans, math.max(111, preferredHeight + 40))
end

function TianShiNaNaTalkView:onClose()
	self._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(self._showNextChar, self)
end

return TianShiNaNaTalkView
