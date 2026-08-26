-- chunkname: @modules/logic/turnback/view/TurnbackSignInItem.lua

module("modules.logic.turnback.view.TurnbackSignInItem", package.seeall)

local TurnbackSignInItem = class("TurnbackSignInItem", ListScrollCell)

function TurnbackSignInItem:init(go)
	self.go = go
	self._gonormalBG = gohelper.findChild(self.go, "Root/#go_normalBG")
	self._gocangetBG = gohelper.findChild(self.go, "Root/#go_cangetBG")
	self._btncanget = gohelper.findChildButtonWithAudio(self.go, "Root/#go_getclick")
	self._txtday = gohelper.findChildText(self.go, "Root/#txt_day")
	self._txtdayEn = gohelper.findChildText(self.go, "Root/#txt_dayEn")
	self._gotomorrowTag = gohelper.findChild(self.go, "Root/#go_tomorrowTag")
	self._goitemContent = gohelper.findChild(self.go, "Root/#go_itemContent")
	self._gohasget = gohelper.findChild(self.go, "Root/#go_hasget")
	self._gogetIconContent = gohelper.findChild(self.go, "Root/#go_hasget/#go_getIconContent")
	self._gogeticon = gohelper.findChild(self.go, "Root/#go_hasget/#go_getIconContent/#go_geticon")
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._goEffectCube = gohelper.findChild(self.go, "Root/#go_cangetBG/kelinqu")

	gohelper.setActive(self.go, false)
	gohelper.setActive(self._gogeticon, false)

	self._itemsTab = {}
	self._firstEnter = true
	self._openAnimTime = 0.97
end

function TurnbackSignInItem:addEventListeners()
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
end

function TurnbackSignInItem:removeEventListeners()
	self._btncanget:RemoveClickListener()
end

function TurnbackSignInItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo

	self:_refreshUI()

	self._delayTime = self._index * 0.03

	if self._firstEnter then
		TaskDispatcher.runDelay(self._playOpenAnim, self, self._delayTime)
	end
end

function TurnbackSignInItem:_refreshUI()
	self:_refreshBonus()

	self._txtday.text = string.format("%02d", self.mo.id)
	self._txtdayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(self.mo.id))

	gohelper.setActive(self._gocangetBG, self.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._btncanget.gameObject, self.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(self._gohasget, self.mo.state == TurnbackEnum.SignInState.HasGet)

	local maxDay = GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList())
	local curSignInDay = TurnbackModel.instance:getCurSignInDay()

	gohelper.setActive(self._gotomorrowTag, curSignInDay + 1 == self.mo.id and curSignInDay ~= maxDay)
end

function TurnbackSignInItem:_refreshBonus()
	self.config = self.mo.config

	local rewards = string.split(self.config.bonus, "|")

	gohelper.setActive(self._goEffectCube, #rewards < 2)

	for i = 1, #rewards do
		local item = self._itemsTab[i]

		if not item then
			item = {
				item = IconMgr.instance:getCommonPropItemIcon(self._goitemContent),
				getIcon = gohelper.clone(self._gogeticon, self._gogetIconContent)
			}

			table.insert(self._itemsTab, item)
		end

		local itemCo = string.split(rewards[i], "#")

		item.item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		item.item:setHideLvAndBreakFlag(true)
		item.item:hideEquipLvAndBreak(true)
		item.item:setCountFontSize(40)
		item.item:setPropItemScale(0.76)
		gohelper.setActive(self._itemsTab[i].item.go, true)
		gohelper.setActive(item.getIcon, true)
	end

	for i = #rewards + 1, #self._itemsTab do
		gohelper.setActive(self._itemsTab[i].item.go, false)
		gohelper.setActive(self._itemsTab[i].getIcon, false)
	end
end

function TurnbackSignInItem:_btncangetOnClick()
	if self.mo.state == TurnbackEnum.SignInState.CanGet then
		local turnbackId = self.mo.turnbackId

		TurnbackRpc.instance:sendTurnbackSignInRequest(turnbackId, self.mo.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function TurnbackSignInItem:_playOpenAnim()
	gohelper.setActive(self.go, true)
	self._animator:Play(UIAnimationName.Open, 0, self:_getOpenAnimPlayProgress())

	self._firstEnter = false
end

function TurnbackSignInItem:_getOpenAnimPlayProgress()
	local curTimeStamp = UnityEngine.Time.realtimeSinceStartup
	local startTimeStamp = TurnbackSignInModel.instance:getOpenTimeStamp()

	return (Mathf.Clamp01((curTimeStamp - startTimeStamp - self._delayTime) / self._openAnimTime))
end

function TurnbackSignInItem:onDestroy()
	TaskDispatcher.cancelTask(self._playOpenAnim, self)
end

return TurnbackSignInItem
