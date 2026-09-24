-- chunkname: @modules/logic/college/view/common/CollegeCurrencyToolItem.lua

module("modules.logic.college.view.common.CollegeCurrencyToolItem", package.seeall)

local CollegeCurrencyToolItem = class("CollegeCurrencyToolItem", ListScrollCell)

function CollegeCurrencyToolItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._imageIcon = gohelper.findChildImage(self.go, "#simage_Icon")
	self._txtNum = gohelper.findChildText(self.go, "content/#txt_Num")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._goEffect = gohelper.findChild(self.go, "#go_Effect")

	gohelper.setActive(self._goEffect, false)

	self._clickTran = self._btnClick.transform
	self._changeDuration = 0.3
	self._anim = gohelper.findComponentAnim(self.go)
end

function CollegeCurrencyToolItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateBag, self._onUpdateBag, self)
end

function CollegeCurrencyToolItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function CollegeCurrencyToolItem:_btnClickOnClick()
	local screenPos = recthelper.uiPosToScreenPos(self._tran)
	local viewParam = {
		itemId = self._currencyId,
		screenPos = screenPos,
		clickParentView = self._parentView,
		clickItem = self
	}

	ViewMgr.instance:openView(ViewName.CollegeCurrencyTipsView, viewParam)
end

function CollegeCurrencyToolItem:onUpdateMO(currencyCo, clientDataMo, isCoin, index, parentView)
	self._currencyCo = currencyCo
	self._currencyId = self._currencyCo and self._currencyCo.id
	self._clientDataMo = clientDataMo
	self._isCoin = isCoin
	self._index = index
	self._parentView = parentView

	self:refreshUI()
end

function CollegeCurrencyToolItem:refreshUI()
	self:initData()
	self:tween2TargetNum()
	CollegeIconHelper.setItemIcon(self._currencyId, self._imageIcon)
end

function CollegeCurrencyToolItem:initData()
	self._resultNum = CollegeModel.instance:getItemCount(self._currencyId)

	if self._resultNum ~= self._toNum and self._toNum then
		self:updateChangeEffect(self._resultNum - self._toNum)
	end

	if self._isCoin then
		self._isNeedPlay, self._fromNum, self._toNum = false
	else
		self._toNum = self._resultNum
		self._fromNum = self._fromNum or self._toNum
		self._isNeedPlay = self._fromNum ~= self._toNum
	end

	self._isAddNum = self._isNeedPlay and self._toNum - self._fromNum > 0
end

function CollegeCurrencyToolItem:tween2TargetNum()
	self:killTween()

	if not self._isNeedPlay then
		self:setCurrencyNum(self._resultNum)

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._fromNum, self._toNum, self._changeDuration, self._frameCallback, self._doneCallback, self)
end

function CollegeCurrencyToolItem:setCurrencyNum(currencyNum)
	self._txtNum.text = currencyNum or 0
	self._fromNum = currencyNum
end

function CollegeCurrencyToolItem:updateChangeEffect(addNum)
	self._pool = self._pool or self:getUserDataTb_()

	local go = table.remove(self._pool) or gohelper.cloneInPlace(self._goEffect)

	gohelper.setActive(go, true)

	local txtEffectReduceNum = gohelper.findChildText(go, "reduce")
	local txtEffectAddNum = gohelper.findChildText(go, "add")

	gohelper.setActive(txtEffectAddNum, addNum > 0)
	gohelper.setActive(txtEffectReduceNum, addNum < 0)

	if addNum > 0 then
		if not ("+" .. addNum) then
			local updateNumStr = addNum

			txtEffectAddNum.text = updateNumStr
			txtEffectReduceNum.text = updateNumStr

			TaskDispatcher.runDelay(function()
				if not self.go or gohelper.isNil(go) then
					return
				end

				gohelper.setActive(go, false)
				table.insert(self._pool, go)
			end, self, 0.5)

			if addNum > 0 then
				self._anim:Play("get", 0, 0)
				CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.ResAdd)
			end
		end
	end
end

function CollegeCurrencyToolItem:_frameCallback(value)
	value = math.ceil(value)

	self:setCurrencyNum(value)
end

function CollegeCurrencyToolItem:_doneCallback()
	self._tweenId = nil
end

function CollegeCurrencyToolItem:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function CollegeCurrencyToolItem:_onUpdateBag()
	self:refreshUI()
end

function CollegeCurrencyToolItem:isMouseOverGo(mousePosition)
	return gohelper.isMouseOverGo(self._clickTran, mousePosition)
end

function CollegeCurrencyToolItem:onDestroy()
	self:killTween()
end

return CollegeCurrencyToolItem
