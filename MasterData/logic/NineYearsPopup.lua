-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/NineYearsPopup.lua

module("logic.extensions.accumulategift.view.NineYearsPopup", package.seeall)

local NineYearsPopup = class("NineYearsPopup", ViewComponent)

function NineYearsPopup:ctor()
	NineYearsPopup.super.ctor(self)

	self._iconCountList = {
		1,
		1,
		1,
		1,
		2,
		3,
		2,
		2,
		2,
		1
	}
	self._iconPath = "ui/bigbg/zhounianqiandao/%s.png"
	self._isFirstPlay = true
	self.isPlayList = nil
end

function NineYearsPopup:buildUI()
	NineYearsPopup.super.buildUI(self)

	self.closeBtn = self:getBtn("closeBtn")
	self.iconImaGo = self:getGo("iconImaGo")
	self.effectGo = self:getGo("effectGo")
	self.contentTxt = self:getGo("contentTxt"):GetComponent("Text")
	self.slideLeftBtn = self:getBtn("slideLeftBtn")
	self.slideRightBtn = self:getBtn("slideRightBtn")
	self.slideLeftGo = self:getGo("slideLeftBtn/slideLeftGo")
	self.slideRightGo = self:getGo("slideRightBtn/slideRightGo")

	self.iconImaGo:SetActive(false)

	self.contentTxt.text = ""

	GameUtil.SetActive(self.slideLeftBtn, false)
	GameUtil.SetActive(self.slideRightBtn, false)
end

function NineYearsPopup:bindEvents()
	NineYearsPopup.super.bindEvents(self)
	self.closeBtn:AddClickListener(function()
		local id = self._matSetId

		self:close()

		if id then
			MaterialController.instance:showChangeSetInTemp(id)
		end
	end, self)
	self.slideLeftBtn:AddClickListener(function()
		self:_OnClickSlideBtn(true)
	end, self)
	self.slideRightBtn:AddClickListener(function()
		self:_OnClickSlideBtn(false)
	end, self)
end

function NineYearsPopup:unbindEvents()
	NineYearsPopup.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.slideLeftBtn:RemoveClickListener()
	self.slideRightBtn:RemoveClickListener()
end

function NineYearsPopup:onExit()
	NineYearsPopup.super.onExit(self)
	removetimer(self._WaitShowViewHand, self)
	removetimer(self._CalculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
	self._isFirstPlay = true
	self.isPlayList = nil
	self._matSetId = nil
end

function NineYearsPopup:destroyUI()
	NineYearsPopup.super.destroyUI(self)

	local bgBig = self.iconImaGo:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end
end

function NineYearsPopup:onEnter()
	NineYearsPopup.super.onEnter(self)

	self._chosDay = 1
	self._chosIndex = 1

	if self._viewPresentor._openParam and self._viewPresentor._openParam[1] then
		self._chosDay = self._viewPresentor._openParam[1]
	end

	self._matSetId = nil

	if self._viewPresentor._openParam and self._viewPresentor._openParam[2] then
		self._matSetId = self._viewPresentor._openParam[2]
	end

	self._allDay = self._chosDay
	self.contentTxt.text = ""

	GameUtil.SetActive(self.closeBtn, false)
	self:_ShowLeftSlideBtn(false)
	self:_ShowRightSlideBtn(false)
	self.iconImaGo:SetActive(false)

	local effPath = "fx_ui_jiuzhounian/fx_ui_shiguangji_jiuzhounian.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.effectGo, 0, 0, false, nil, nil, nil, self)

	self._pmEff:setParent(self.effectGo.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	settimer(1.5, self._WaitShowViewHand, self)
end

function NineYearsPopup:_WaitShowViewHand()
	removetimer(self._WaitShowViewHand, self)
	self:_StartShowViewImage()
end

function NineYearsPopup:_StartShowViewImage()
	self.iconImaGo:SetActive(true)

	self._chosIndex = 1

	local iconName = "zhounian_qd_" .. self._chosDay

	if self._iconCountList[self._chosDay] > 1 then
		iconName = iconName .. "_" .. self._chosIndex
	end

	uGuiUtil.setSpriteToImage(self.iconImaGo, uGuiUtil.SpriteType.BigBg, string.format(self._iconPath, iconName))

	self.isPlayList = {}

	self:_StartDisplayContent()
end

function NineYearsPopup:_OnClickSlideBtn(isLeft)
	if isLeft then
		if self._chosIndex <= 1 and checknumber(self._iconCountList[self._chosDay - 1]) <= 0 then
			return
		end

		self._chosIndex = self._chosIndex - 1
	else
		if self._chosIndex >= self._iconCountList[self._chosDay] and self._chosDay >= self._allDay then
			return
		end

		self._chosIndex = self._chosIndex + 1
	end

	if self._chosIndex <= 0 then
		self._chosDay = self._chosDay - 1
		self._chosIndex = self._iconCountList[self._chosDay]
	elseif self._chosIndex > self._iconCountList[self._chosDay] then
		self._chosDay = self._chosDay + 1
		self._chosIndex = 1
	end

	local iconName = "zhounian_qd_" .. self._chosDay

	if self._iconCountList[self._chosDay] > 1 then
		iconName = iconName .. "_" .. self._chosIndex
	end

	uGuiUtil.setSpriteToImage(self.iconImaGo, uGuiUtil.SpriteType.BigBg, string.format(self._iconPath, iconName))

	if self._isFirstPlay and self._allDay ~= self._chosDay then
		self._isFirstPlay = false
	end

	if self._isFirstPlay and self.isPlayList[self._chosIndex] then
		self._isFirstPlay = false
	end

	if self._matSetId and self._isFirstPlay then
		GameUtil.SetActive(self.closeBtn, false)
		self:_ShowLeftSlideBtn(false)
		self:_ShowRightSlideBtn(false)
	end

	self:_StartDisplayContent()
end

function NineYearsPopup:_ShowLeftAndRightBtn()
	GameUtil.SetActive(self.closeBtn, true)

	if self._chosIndex <= 1 and checknumber(self._iconCountList[self._chosDay - 1]) <= 0 then
		self:_ShowLeftSlideBtn(false)
	else
		self:_ShowLeftSlideBtn(true)
	end

	if self._chosIndex >= self._iconCountList[self._chosDay] and self._chosDay >= self._allDay then
		self:_ShowRightSlideBtn(false)
	else
		self:_ShowRightSlideBtn(true)
	end
end

function NineYearsPopup:_ShowLeftSlideBtn(_isPlay)
	if _isPlay then
		GameUtil.SetActive(self.slideLeftBtn, true)
		UnityTweens.TweenPosition.StartTween(self.slideLeftGo, Vector3.New(10, 0, 0), Vector3.New(-15, 0, 0), 0.6, UnityTweens.EaseType.easeInSine)
		UnityTweens.UITweenFade.StartTween(self.slideLeftGo, 1, 0, 0.6, UnityTweens.EaseType.easeInQuad)
	else
		UnityTweens.UITweenFade.StopTween(self.slideLeftGo)
		UnityTweens.TweenPosition.StopTween(self.slideLeftGo)
		GameUtil.SetActive(self.slideLeftBtn, false)
	end
end

function NineYearsPopup:_ShowRightSlideBtn(_isPlay)
	if _isPlay then
		GameUtil.SetActive(self.slideRightBtn, true)
		UnityTweens.TweenPosition.StartTween(self.slideRightGo, Vector3.New(-10, 0, 0), Vector3.New(15, 0, 0), 0.6, UnityTweens.EaseType.easeInSine)
		UnityTweens.UITweenFade.StartTween(self.slideRightGo, 1, 0, 0.6, UnityTweens.EaseType.easeInQuad)
	else
		UnityTweens.UITweenFade.StopTween(self.slideRightGo)
		UnityTweens.TweenPosition.StopTween(self.slideRightGo)
		GameUtil.SetActive(self.slideRightBtn, false)
	end
end

function NineYearsPopup:_StartDisplayContent()
	self.contentTxt.text = ""

	local _num = self._chosIndex

	if self._chosDay > 1 then
		for i = 1, self._chosDay - 1 do
			if checknumber(self._iconCountList[i]) > 0 then
				_num = _num + self._iconCountList[i]
			end
		end
	end

	local _textCfg = OperationSignInConfig.instance:getSignContentCfg(_num)

	if _textCfg == nil or string.nilorempty(_textCfg.content) then
		self:_ShowLeftAndRightBtn()

		return
	end

	if not self._matSetId or not self._isFirstPlay then
		self.contentTxt.text = _textCfg.content

		self:_ShowLeftAndRightBtn()

		return
	end

	if self._allDay == self._chosDay then
		self.isPlayList[self._chosIndex] = true
	end

	self._txtAllCount = self:_GetStringTable(_textCfg.content)
	self._txtTempCount = 0
	self._textContent = _textCfg.content

	settimer(0.2, self._CalculationSurplusTime, self, true)
end

function NineYearsPopup:_CalculationSurplusTime()
	self._txtTempCount = self._txtTempCount + 1

	if self._txtTempCount >= self._txtAllCount then
		self.contentTxt.text = self._textContent

		self:_ShowLeftAndRightBtn()
		removetimer(self._CalculationSurplusTime, self)

		return
	end

	self.contentTxt.text = self:_SubStringContent(self._txtTempCount)
end

function NineYearsPopup:_GetStringTable(str)
	self._contentList = {}

	if GameUtil.isEmptyString(str) then
		return 0
	end

	for i = 1, #str do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			table.insert(self._contentList, 1)
		elseif byte >= 192 and byte <= 239 then
			table.insert(self._contentList, 3)

			i = i + 3
		end
	end

	return #self._contentList
end

function NineYearsPopup:_SubStringContent(count)
	if checknumber(count) <= 0 or count > #self._contentList then
		return
	end

	local index = 0

	for i = 1, count do
		index = index + self._contentList[i]
	end

	if index <= 0 then
		return
	end

	return string.sub(self._textContent, 1, index)
end

return NineYearsPopup
