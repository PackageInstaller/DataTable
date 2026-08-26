-- chunkname: @modules/logic/player/view/WaterMarkView.lua

module("modules.logic.player.view.WaterMarkView", package.seeall)

local WaterMarkView = class("WaterMarkView", BaseView)

function WaterMarkView:onInitView()
	self.goWaterMarkTemplate = gohelper.findChild(self.viewGO, "#txt_template")

	gohelper.setActive(self.goWaterMarkTemplate, false)

	self.goWaterMarkList = self:getUserDataTb_()

	local IdCanvasPopUp = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)

	self.maxWidth = recthelper.getWidth(IdCanvasPopUp.transform)
	self.maxHeight = recthelper.getHeight(IdCanvasPopUp.transform)
	self.wInterval = 200
	self.hInterval = 100
end

function WaterMarkView:onOpen()
	self:updateWaterMark(self.viewParam.userId)
end

function WaterMarkView:updateWaterMark(userId)
	if GameChannelConfig.getServerType() == GameChannelConfig.ServerType.Develop and BootNativeUtil.isWindows() then
		userId = LoginModel.instance.channelUserId
	end

	if userId == self.userId then
		return
	end

	self.userId = userId

	local numRow = math.floor(self.maxHeight / self.hInterval) + 1
	local numCol = math.floor(self.maxWidth / self.wInterval) + 1
	local index = 0

	for rowIndex = 0, numRow do
		for colIndex = 0, numCol do
			index = index + 1

			local txtWaterMark = self.goWaterMarkList[index]

			if not txtWaterMark then
				local goWaterMark = gohelper.cloneInPlace(self.goWaterMarkTemplate)

				txtWaterMark = goWaterMark:GetComponent(gohelper.Type_TextMesh)

				table.insert(self.goWaterMarkList, txtWaterMark)
			end

			gohelper.setActive(txtWaterMark.gameObject, true)

			txtWaterMark.text = self.userId
			txtWaterMark.color = (colIndex + rowIndex) % 2 == 0 and Color.New(1, 1, 1, 0.16) or Color.New(0, 0, 0, 0.16)

			recthelper.setAnchor(txtWaterMark.gameObject.transform, colIndex * self.wInterval, rowIndex * self.hInterval)
		end
	end

	for i = index + 1, #self.goWaterMarkList do
		gohelper.setActive(self.goWaterMarkList[i].gameObject, false)
	end
end

function WaterMarkView:hideWaterMark()
	gohelper.setActive(self.viewGO, false)
end

function WaterMarkView:showWaterMark()
	gohelper.setActive(self.viewGO, true)
end

function WaterMarkView:onDestroyView()
	self.goWaterMarkList = nil
end

return WaterMarkView
