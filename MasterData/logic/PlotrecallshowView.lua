-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/view/PlotrecallshowView.lua

module("logic.extensions.plotcopy.view.PlotrecallshowView", package.seeall)

local PlotrecallshowView = class("PlotrecallshowView", ViewComponent)

function PlotrecallshowView:ctor()
	PlotrecallshowView.super.ctor(self)
end

function PlotrecallshowView:buildUI()
	PlotrecallshowView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnLeft = self:getBtn("Middle/btn_left")
	self._btnRight = self:getBtn("Middle/btn_right")
	self._shareBtn = self:getBtn("shareBtn")
	self.page = PageComponent.New()

	self.page:init(self:getGo("page"), self:getGo("PageCell"), 1600, 720, 1600, 8)
	self.page:setUpdateCallBack(GameUtil.handler(self._updateCell, self))
	self.page:setMoveEndCallBack(GameUtil.handler(self._onSetOffsetFinish, self))
end

function PlotrecallshowView:bindEvents()
	PlotrecallshowView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitch(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitch(false)
	end, self)
	self._shareBtn:AddClickListener(function()
		ShareController.instance:share(1, {
			self._shareBtn.gameObject
		}, nil, 200289)
	end)
end

function PlotrecallshowView:unbindEvents()
	PlotrecallshowView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._shareBtn:RemoveClickListener()
end

function PlotrecallshowView:destroyUI()
	PlotrecallshowView.super.destroyUI(self)
end

function PlotrecallshowView:onEnter()
	PlotrecallshowView.super.onEnter(self)

	self._curViewDatas = PlotRecallModel.instance:getAllUnlockCG()
	self._curIndex = PlotRecallModel.instance:getSelectCGId()

	self.page:setData(self._curViewDatas)
	self.page:moveToIdx(self._curIndex - 1)
end

function PlotrecallshowView:onEnterFinished()
	PlotrecallshowView.super.onEnterFinished(self)
end

function PlotrecallshowView:onExit()
	PlotrecallshowView.super.onExit(self)
end

function PlotrecallshowView:onExitFinished()
	PlotrecallshowView.super.onExitFinished(self)
end

function PlotrecallshowView:close()
	PlotrecallshowView.super.close(self)

	local bigBg = self.imgBg:GetComponent("ImageBigBG")

	if bigBg then
		bigBg:ClearImage()
	end
end

function PlotrecallshowView:_updateCell(cell, data, idx)
	self.imgBg = goutil.findChild(cell, "imgBg"):GetComponent(goutil.Type_UIImage)
	self.txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	self.txtContent = goutil.findChildTextComponent(cell, "txtContent")
	self.txtTitle.text = data.imgTitle
	self.txtContent.text = data.imgContent

	uGuiUtil.setSpriteToImage(self.imgBg.gameObject, uGuiUtil.SpriteType.BigBg, StoryConst.StoryPath_BigImgBg .. data.imgSrc .. ".png")
end

function PlotrecallshowView:_onSetOffsetFinish()
	self:_updateSwitchBtnStatus()
end

function PlotrecallshowView:_onClickSwitch(isLeft)
	if isLeft then
		self.page:prePage()
	else
		self.page:nextPage()
	end
end

function PlotrecallshowView:_updateSwitchBtnStatus()
	goutil.setActive(self._btnLeft.gameObject, self.page:getCurIndex() > 0)
	goutil.setActive(self._btnRight.gameObject, self.page:getCurIndex() + 1 < #self._curViewDatas)
end

function PlotrecallshowView:_onSelectIdChange()
	PlotRecallModel.instance:setSelectCGId(self._curIndex)
end

return PlotrecallshowView
