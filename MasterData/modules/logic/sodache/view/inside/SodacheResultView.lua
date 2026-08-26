-- chunkname: @modules/logic/sodache/view/inside/SodacheResultView.lua

module("modules.logic.sodache.view.inside.SodacheResultView", package.seeall)

local SodacheResultView = class("SodacheResultView", BaseView)

function SodacheResultView:onInitView()
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._txtvalue = gohelper.findChildTextMesh(self.viewGO, "layout/#go_currency/#txt_currency")
	self._txtvalue2 = gohelper.findChildTextMesh(self.viewGO, "layout/#go_value/#txt_value")
	self._gocard = gohelper.findChild(self.viewGO, "layout/#go_card")
	self._gocardItem = gohelper.findChild(self.viewGO, "layout/#go_card/#scroll_card/viewport/content/carditem")
	self._animlayout = gohelper.findChildAnim(self.viewGO, "layout")
	self._goeffect1 = gohelper.findChild(self.viewGO, "#add_num")
	self._goeffect2 = gohelper.findChild(self.viewGO, "#fly")
end

function SodacheResultView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function SodacheResultView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function SodacheResultView:onOpen()
	local isWin = self.viewParam.isWin

	if isWin then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.settle_win)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.settle_lose)
	end

	self._anim:Play(isWin and "success" or "fail")
	gohelper.setActive(self._gofail, not isWin)
	gohelper.setActive(self._gosuccess, isWin)

	self._txtvalue.text = "0"
	self._txtvalue2.text = "0"

	local datas = {}
	local haveSell = false

	for i, v in ipairs(self.viewParam.rewards) do
		for _, vv in ipairs(v.items) do
			local itemMo = GameUtil.rpcInfoToMo(vv, SodacheItemMo)

			table.insert(datas, {
				cardMo = itemMo:toCardMo(),
				isSell = v.type == 1
			})
		end

		haveSell = haveSell or v.type == 1
	end

	self._datas = datas

	table.sort(datas, function(a, b)
		if a.isSell ~= b.isSell then
			return a.isSell
		end

		local aCardMo = a.cardMo
		local bCardMo = b.cardMo
		local isAAtlas = aCardMo.serverMo.itemCo.type == SodacheEnum.CardType.Offering
		local isBAtlas = bCardMo.serverMo.itemCo.type == SodacheEnum.CardType.Offering

		if isAAtlas ~= isBAtlas then
			return isAAtlas
		end

		local aColor = aCardMo.serverMo.itemCo.quality
		local bColor = bCardMo.serverMo.itemCo.quality

		if aColor ~= bColor then
			return bColor < aColor
		end

		return aCardMo.serverMo.configId < bCardMo.serverMo.configId
	end)

	self._anims = self:getUserDataTb_()

	gohelper.setActive(self._gocard, #self._datas > 0)

	self._isHaveNoSell = false

	TaskDispatcher.runDelay(self._delayPlayAnim, self, 1)

	if #self._datas > 0 then
		gohelper.CreateObjList(self, self._createCardList, self._datas, nil, self._gocardItem)

		if not self._isHaveNoSell then
			TaskDispatcher.runDelay(self._hideCard, self, 2.2)
		end
	end
end

function SodacheResultView:_hideCard()
	self._animlayout:Play("card_close")
end

function SodacheResultView:_delayPlayAnim()
	if self.viewParam.goldCount > 0 or self.viewParam.currencyCount > 0 then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.2, self._dofloat, nil, self)
	end

	if #self._anims > 0 then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.settle_change)
		gohelper.setActive(self._goeffect1, true)
		gohelper.setActive(self._goeffect2, true)

		for i, v in ipairs(self._anims) do
			v:Play("didsappear")
		end
	end
end

function SodacheResultView:_dofloat(value)
	self._txtvalue.text = math.floor(value * self.viewParam.goldCount)
	self._txtvalue2.text = math.floor(value * self.viewParam.currencyCount)
end

function SodacheResultView:_createCardList(obj, data, index)
	local cardGo = gohelper.findChild(obj, "sodache_carditem")
	local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, SodacheCardItem)

	cardItem:updateMo(data.cardMo)

	if data.isSell then
		table.insert(self._anims, gohelper.findComponentAnim(obj))
	else
		self._isHaveNoSell = true
	end
end

function SodacheResultView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
	TaskDispatcher.cancelTask(self._hideCard, self)
end

return SodacheResultView
