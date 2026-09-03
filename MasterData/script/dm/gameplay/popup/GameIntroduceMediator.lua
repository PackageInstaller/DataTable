-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/GameIntroduceMediator.lua

GameIntroduceMediator = class("GameIntroduceMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["main.left"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.right"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.close"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onTouchMaskLayer"
	}
}

function GameIntroduceMediator:initialize()
	super.initialize(self)
end

function GameIntroduceMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function GameIntroduceMediator:onRemove()
	super.onRemove(self)
end

function GameIntroduceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initUI()
end

function GameIntroduceMediator:userInject()
	return
end

function GameIntroduceMediator:enterWithData(data)
	self:initData(data)
	self:setUI()
end

function GameIntroduceMediator:initData(data)
	assert(data.key ~= nil, "GameIntroduce Key is empty.")

	self._introduceKey = data.key
	self._cellOffsetX = 0
	self._curIndex = 1
	self._cellNode = {}
	self._cellWidth = self._infoCell:getContentSize().width
	self._cellHeight = self._infoCell:getContentSize().height
	self._scrollWidth = self._scrollView:getContentSize().width
	self._scrollHeight = self._scrollView:getContentSize().height
	self._config = ConfigReader:getRecordById("PicGuide", self._introduceKey)
	self._infoListNum = #self._config.Pic
end

function GameIntroduceMediator:initUI()
	self._view = self:getView()
	self._main = self._view:getChildByFullName("main")
	self._infoCell = self._view:getChildByFullName("abcCell")

	self._infoCell:setVisible(false)

	self._scrollView = self._main:getChildByFullName("listPanel")
	self._leftBtn = self._main:getChildByFullName("left")
	self._rightBtn = self._main:getChildByFullName("right")
	self._num = self._main:getChildByFullName("pageIdx.num")
	self._total = self._main:getChildByFullName("pageIdx.total")
	self._closeBtn = self._main:getChildByFullName("close")
end

function GameIntroduceMediator:setUI()
	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setInertiaScrollEnabled(false)
	self._scrollView:onScroll(function(event)
		self:onScroll(event)
	end)
	self._scrollView:onTouch(function(event)
		self:onTouch(event)
	end)
	self._scrollView:removeAllChildren()

	for i = 1, self._infoListNum do
		local infoCell = self._infoCell:clone()

		infoCell:setVisible(true)
		self._scrollView:addChild(infoCell)
		infoCell:setSwallowTouches(false)
		infoCell:setTag(i)

		local posX = self._scrollWidth / 2 + (self._cellWidth + self._cellOffsetX) * (i - 1) - self._cellOffsetX / 2

		dump(posX, "posX >>>>>>")
		infoCell:setPosition(cc.p(posX, 296))
		self:setInfoUI(infoCell, i)

		self._cellNode[i] = infoCell
		self._cellNode[i].position = {
			infoCell:getPositionX(),
			infoCell:getPositionY()
		}
	end

	local offset = self._scrollWidth - self._cellWidth
	local width = math.max(offset + self._infoListNum * self._cellWidth + (self._infoListNum - 1) * self._cellOffsetX, self._scrollWidth)

	self._scrollView:setInnerContainerSize(cc.size(width, self._scrollHeight))
	self._scrollView:scrollToPercentHorizontal(0, 0.1, false)
	self:setInfoCellStates()
	self:refreshView()
	self:initAnim()
end

function GameIntroduceMediator:setInfoUI(cell, idx)
	local pageIdx = cell:getChildByFullName("pageIdx")

	pageIdx:setString(tostring(idx) .. "/" .. tostring(self._infoListNum))

	local descLabel = cell:getChildByFullName("infoLab")
	local richText = ccui.RichText:createWithXML(Strings:get(self._config.Pic[idx].TransID, {
		fontSize = 20,
		fontName = TTF_FONT_FZYH_R
	}), {})

	richText:setAnchorPoint(descLabel:getAnchorPoint())
	richText:setPosition(cc.p(descLabel:getPosition()))
	richText:addTo(descLabel:getParent())
	richText:renderContent(descLabel:getContentSize().width, 0, true)

	local pageImg = cell:getChildByFullName("page")

	pageImg:loadTexture("asset/ui/introduce/" .. self._config.Pic[idx].pic, ccui.TextureResType.localType)
end

function GameIntroduceMediator:onScroll(event)
	if event.name == "CONTAINER_MOVED" then
		self:setInfoCellStates()
	end
end

function GameIntroduceMediator:onTouch(event)
	if event.name == "ended" or event.name == "cancelled" then
		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local curIndex = math.floor(math.abs(scrollPosX) / (self._cellWidth + self._cellOffsetX) + 0.5) + 1

		self:scrollToCurIndex(curIndex)
	end
end

function GameIntroduceMediator:scrollToCurIndex(curIndex)
	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._scrollWidth
	local percent = (curIndex - 1) * (self._cellWidth + self._cellOffsetX) / scrollInnerWidth

	if self._curIndex ~= curIndex then
		self._curIndex = math.min(self._infoListNum, curIndex)

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)
	self:refreshView()
end

function GameIntroduceMediator:setInfoCellStates()
	local middlePoint = cc.p(self._scrollView:getContentSize().width / 2, 0)

	for i = 1, self._infoListNum do
		local v = self._scrollView:getChildByTag(i)
		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local posX = v:getPositionX()
		local absPos = math.abs(posX - math.abs(scrollPosX) - self._scrollWidth / 2 + self._cellOffsetX / 2)
		local scaleNew = 1 - absPos / (self._cellWidth + self._cellOffsetX) * 0.2

		v:setScale(scaleNew)

		local colorOps = 1 - absPos / (self._cellWidth + self._cellOffsetX) * 0.4
		local colorNew = cc.c3b(255 * colorOps, 255 * colorOps, 255 * colorOps)

		v:setColor(colorNew)
	end
end

function GameIntroduceMediator:refreshView()
	self._leftBtn:setVisible(self._curIndex > 1)
	self._rightBtn:setVisible(self._curIndex < self._infoListNum)
	self._num:setString(tostring(self._curIndex))
	self._total:setString("/" .. tostring(self._infoListNum))
end

function GameIntroduceMediator:initAnim()
	self._rightBtn:stopAllActions()
	self._leftBtn:stopAllActions()

	local fadeIn = cc.FadeIn:create(0.4)
	local scaleTo1 = cc.ScaleTo:create(0.4, 1.2)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local easeInOut = cc.EaseInOut:create(spawn, 1)
	local scaleTo2 = cc.ScaleTo:create(0.4, 1)
	local fadeout = cc.FadeOut:create(0.4)
	local spawn1 = cc.Spawn:create(fadeout, scaleTo2)
	local easeInOut1 = cc.EaseInOut:create(spawn1, 1)
	local action = cc.Sequence:create(easeInOut, easeInOut1)
	local action2 = action:clone()

	self._rightBtn:runAction(cc.RepeatForever:create(action))
	self._leftBtn:runAction(cc.RepeatForever:create(action2))
end

function GameIntroduceMediator:onClickLeft()
	if self._curIndex <= 1 then
		return
	end

	self:scrollToCurIndex(self._curIndex - 1)
end

function GameIntroduceMediator:onClickRight()
	if self._curIndex >= self._infoListNum then
		return
	end

	self:scrollToCurIndex(self._curIndex + 1)
end
