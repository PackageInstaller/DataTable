-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBuffView.lua

module("logic.extensions.shenjichallenge.view.ShenJiBuffView", package.seeall)

local ShenJiBuffView = class("ShenJiBuffView", ViewComponent)

function ShenJiBuffView:buildUI()
	ShenJiBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function ShenJiBuffView:bindEvents()
	ShenJiBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	self._txtScore = self:getTxt("score/txtScore")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._sliderRect = self:getGo("tableview/viewport/content/slider"):GetComponent(goutil.Type_RectTransform)
	self._imgFill = self:getImg("tableview/viewport/content/slider/imgFill")
	self._scoreIcon = self:getGo("score/icon")
end

function ShenJiBuffView:unbindEvents()
	ShenJiBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShenJiBuffView:onEnter()
	ShenJiBuffView.super.onEnter(self)
	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._activityId = self:getFirstParam()
	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._buffValue = ShenJiChallengeModel.instance:getBuffValue()
	self._buffList = self:_getBuffList()

	self:_updateScore()
	self:_updateList()
	self:_initIcon()
end

function ShenJiBuffView:onExit()
	ShenJiBuffView.super.onExit(self)
	self._scrollList:dispose()
	self:_clearIcon()
end

function ShenJiBuffView:_updateCell(view, cell, data, tag)
	local imgBottom = goutil.findChild(cell, "imgBottom")
	local selectGo = goutil.findChild(cell, "select")
	local icon = goutil.findChild(cell, "icon")
	local txtBottom = goutil.findChildTextComponent(cell, "imgBottom/txtBottom")
	local txtTop = goutil.findChildTextComponent(cell, "imgTop/txtTop")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	if data.buffId == 2 then
		goutil.setActive(imgBottom, true)

		txtBottom.text = 0
	else
		goutil.setActive(imgBottom, false)
	end

	txtTop.text = data.value

	local preCfg = ShenJiChallengeConfig.instance:getBuff(self._activityId, data.buffId - 1)
	local isSelect = self._buffValue > preCfg.value and self._buffValue <= data.value

	goutil.setActive(selectGo, isSelect)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.buffIcon))

	txtDesc.text = data.buffDesc
end

function ShenJiBuffView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function ShenJiBuffView:_updateScore()
	self._txtScore.text = self._buffValue
end

function ShenJiBuffView:_getBuffList()
	local cfgs = ShenJiChallengeConfig.instance:getBuffList(self._activityId)
	local list = {}

	for i, v in ipairs(cfgs) do
		if v.value > 0.0001 then
			table.insert(list, v)
		end
	end

	return list
end

function ShenJiBuffView:_updateList()
	self._scrollList:reloadData(self._buffList)
end

function ShenJiBuffView:_onReloadFinish()
	self:_updateSlider()
end

function ShenJiBuffView:_updateSlider()
	local startX, startY = 42, 5
	local contentRect = self._scrollList:getView():GetContent():GetComponent(goutil.Type_RectTransform)
	local height = contentRect.rect.height
	local sliderWidth = height - startY * 2

	goutil.setWidth(self._sliderRect, sliderWidth)

	self._imgFill.fillAmount = self:_getPercentValue()
end

function ShenJiBuffView:_getPercentValue()
	local maxNum = Mathf.Max(1, self._cfgActivity.maxGameValue)
	local minNum = self._cfgActivity.initGameValue
	local curNum = Mathf.Clamp(self._buffValue, minNum, maxNum)
	local count = #self._buffList
	local percent = 0

	for i, v in ipairs(self._buffList) do
		if curNum > v.value then
			percent = percent + 1 / count
		else
			if self._buffList[i - 1] then
				percent = percent + (curNum - self._buffList[i - 1].value) / (v.value - self._buffList[i - 1].value) * (1 / count)

				break
			end

			percent = percent + (curNum - 0) / (v.value - 0) * (1 / count)

			break
		end
	end

	return percent
end

function ShenJiBuffView:_initIcon()
	local iconPath = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "rewardIconPath")

	uGuiUtil.setSpriteToImage(self._scoreIcon, uGuiUtil.SpriteType.BigBg, iconPath)
end

function ShenJiBuffView:_clearIcon()
	uGuiUtil.clearImage(self._scoreIcon)
end

return ShenJiBuffView
