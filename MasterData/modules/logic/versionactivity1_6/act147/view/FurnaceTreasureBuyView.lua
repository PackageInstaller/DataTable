-- chunkname: @modules/logic/versionactivity1_6/act147/view/FurnaceTreasureBuyView.lua

module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureBuyView", package.seeall)

local FurnaceTreasureBuyView = class("FurnaceTreasureBuyView", BaseView)

function FurnaceTreasureBuyView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._txtcontentcn = gohelper.findChildText(self.viewGO, "#go_contents/txt_contentcn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FurnaceTreasureBuyView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospine, true)
end

function FurnaceTreasureBuyView:onOpen()
	self._storeId = self.viewParam and self.viewParam.storeId
	self._goodsId = self.viewParam and self.viewParam.goodsId

	local actId = FurnaceTreasureModel.instance:getActId()
	local dialogList = FurnaceTreasureConfig.instance:getDialogList(actId)
	local dialogCount = #dialogList

	if dialogCount > 0 and self._txtcontentcn then
		local index = math.random(1, #dialogList)

		self._txtcontentcn.text = dialogList[index]
	end

	local spineRes = FurnaceTreasureConfig.instance:getSpineRes(actId)

	if not self._uiSpine or string.nilorempty(spineRes) then
		return
	end

	self._uiSpine:setResPath(spineRes, self._onSpineLoaded, self)
end

function FurnaceTreasureBuyView:_onSpineLoaded()
	if not self._uiSpine then
		return
	end

	self._uiSpine:changeLookDir(SpineLookDir.Left)

	local poolId = FurnaceTreasureModel.instance:getGoodsPoolId(self._storeId, self._goodsId)
	local co = FurnaceTreasureModel.instance:getSpinePlayData(poolId)

	self._uiSpine:playVoice(co)

	local isGreatGoods = poolId == FurnaceTreasureEnum.ActGoodsPool.Great

	AudioMgr.instance:trigger((isGreatGoods or nil) and AudioEnum.UI.FurnaceTreasureBuyViewGreatSpine)
end

function FurnaceTreasureBuyView:onClickModalMask()
	FurnaceTreasureController.instance:BuyFurnaceTreasureGoods(self._storeId, self._goodsId, self.closeThis, self)
end

function FurnaceTreasureBuyView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:doClear()
	end

	self._uiSpine = false

	AudioMgr.instance:trigger(AudioEnum.UI.FurnaceTreasureBuyViewFinish)
end

return FurnaceTreasureBuyView
