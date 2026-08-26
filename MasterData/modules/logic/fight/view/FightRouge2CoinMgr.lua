-- chunkname: @modules/logic/fight/view/FightRouge2CoinMgr.lua

module("modules.logic.fight.view.FightRouge2CoinMgr", package.seeall)

local FightRouge2CoinMgr = class("FightRouge2CoinMgr", UserDataDispose)
local RevivalCoinPath = "ui/viewres/fight/fight_rouge2/fight_rouge2_reviveitem.prefab"
local CoinPath = "ui/viewres/fight/fight_rouge2/fight_rouge2_coin.prefab"

function FightRouge2CoinMgr:ctor(viewContainer)
	self:__onInit()

	self.viewContainer = viewContainer
	self.viewGo = self.viewContainer.viewGO
end

function FightRouge2CoinMgr:start()
	self.revivalLoaded = false

	local revivalEnum = FightRightElementEnum.Elements.Rouge2RevivalCoin

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, revivalEnum)

	local revivalCoinRoot = self.viewContainer.rightElementLayoutView:getElementContainer(revivalEnum)

	self.revivalLoader = PrefabInstantiate.Create(revivalCoinRoot)

	self.revivalLoader:startLoad(RevivalCoinPath, self.onLoadedRevivalCoinDone, self)

	self.coinLoaded = false

	local coinRoot = gohelper.findChild(self.viewGo, "root/right_elements/noLayout/rouge2coin")

	self.coinLoader = PrefabInstantiate.Create(coinRoot)

	self.coinLoader:startLoad(CoinPath, self.onLoadedCoinDone, self)

	self.coinRoot = coinRoot

	self:hideCoin()
	self.addEventCb(self, FightController.instance, FightEvent.UpdateFightParam, self.onUpdateFightParam, self)
end

function FightRouge2CoinMgr:showCoin()
	gohelper.setActive(self.coinRoot, true)
end

function FightRouge2CoinMgr:hideCoin()
	gohelper.setActive(self.coinRoot, false)
end

function FightRouge2CoinMgr:onUpdateFightParam(paramId, oldValue, currValue, offset)
	if paramId == FightParamData.ParamKey.ROUGE2_COIN then
		self:changeCoin(offset)
	end

	if paramId == FightParamData.ParamKey.ROUGE2_REVIVAL_COIN then
		self:changeRevivalCoin(offset)
	end
end

function FightRouge2CoinMgr:onLoadedRevivalCoinDone()
	self.revivalLoaded = true

	local go = self.revivalLoader:getInstGO()
	local rectTr = go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(rectTr, 0, 0)

	self.revivalClick = gohelper.getClickWithDefaultAudio(go)

	self.revivalClick:AddClickListener(self.onClickRevivalCoin, self)

	self.goTip = gohelper.findChild(go, "root/#go_Tips")

	gohelper.setActive(self.goTip, false)

	self.tipClick = gohelper.findChildClickWithDefaultAudio(self.goTip, "#btn_click")

	self.tipClick:AddClickListener(self.onClickTip, self)

	self.txtRevivalCoin = gohelper.findChildText(go, "root/#txt_CoinCnt")

	local image = gohelper.findChildImage(go, "root/#txt_CoinCnt/image_coin")

	UISpriteSetMgr.instance:setFightSprite(image, "fight_rouge2_icon_fuhuobi")

	self.txtRevivalAdd = gohelper.findChildText(go, "root/num/#txt_add")
	self.txtRevivalReduce = gohelper.findChildText(go, "root/num/#txt_reduce")
	self.revivalAddEffectGo = gohelper.findChild(go, "root/obtain")
	self.revivalSubEffectGo = gohelper.findChild(go, "root/without")
	self.txtTipDesc = gohelper.findChildText(self.goTip, "tips/#scroll_dec/viewport/content/#txt_dec")

	self:refreshRevivalCoin()
end

function FightRouge2CoinMgr:onLoadedCoinDone()
	self.coinLoaded = true

	local go = self.coinLoader:getInstGO()
	local rectTr = go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(rectTr, 0, 0)

	self.coinInnerRoot = gohelper.findChild(go, "root")
	self.coinInnerCanvas = self.coinInnerRoot:GetComponent(gohelper.Type_CanvasGroup)

	local image = gohelper.findChildImage(go, "root/#txt_CoinCnt/image_coin")

	UISpriteSetMgr.instance:setCurrencyItemSprite(image, "100603_1")

	self.txtCoin = gohelper.findChildText(go, "root/#txt_CoinCnt")
	self.coinAddEffectGo = gohelper.findChild(go, "root/obtain")
	self.coinSubEffectGo = gohelper.findChild(go, "root/without")

	self:directSetCoin(self:getParamValue(FightParamData.ParamKey.ROUGE2_COIN))
end

function FightRouge2CoinMgr:onClickRevivalCoin()
	gohelper.setActive(self.goTip, true)
end

function FightRouge2CoinMgr:onClickTip()
	gohelper.setActive(self.goTip, false)
end

function FightRouge2CoinMgr:directSetCoin(value)
	if not self.coinLoaded then
		return
	end

	self.tweenCoinValue = value
	self.txtCoin.text = value
end

function FightRouge2CoinMgr:refreshRevivalCoin()
	if not self.revivalLoaded then
		return
	end

	self.txtRevivalCoin.text = self:getParamValue(FightParamData.ParamKey.ROUGE2_REVIVAL_COIN)
	self.txtRevivalAdd.text = ""
	self.txtRevivalReduce.text = ""
	self.txtTipDesc.text = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.RevivalCoinDesc].value2
end

function FightRouge2CoinMgr:changeRevivalCoin(offset)
	if not self.revivalLoaded then
		return
	end

	self.txtRevivalCoin.text = self:getParamValue(FightParamData.ParamKey.ROUGE2_REVIVAL_COIN)

	if offset > 0 then
		gohelper.setActive(self.revivalAddEffectGo, false)
		gohelper.setActive(self.revivalAddEffectGo, true)

		self.txtRevivalAdd.text = "+" .. offset
		self.txtRevivalReduce.text = ""
	else
		gohelper.setActive(self.revivalSubEffectGo, false)
		gohelper.setActive(self.revivalSubEffectGo, true)

		self.txtRevivalReduce.text = "-" .. offset
		self.txtRevivalAdd.text = ""
	end
end

FightRouge2CoinMgr.CoinTweenDuration = 0.5

function FightRouge2CoinMgr:changeCoin(offset)
	if not self.coinLoaded then
		return
	end

	self:showCoin()

	self.coinInnerCanvas.alpha = 1

	self:clearCoinTween()
	TaskDispatcher.cancelTask(self.hideCoinByAnim, self)

	if offset >= 0 then
		gohelper.setActive(self.coinAddEffectGo, false)
		gohelper.setActive(self.coinAddEffectGo, true)
	else
		gohelper.setActive(self.coinSubEffectGo, false)
		gohelper.setActive(self.coinSubEffectGo, true)
	end

	self.targetValue = self:getParamValue(FightParamData.ParamKey.ROUGE2_COIN)
	self.coinTweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenCoinValue, self.targetValue, FightRouge2CoinMgr.CoinTweenDuration, self.onCoinFrame, self.onCoinDone, self)
end

function FightRouge2CoinMgr:onCoinFrame(value)
	self:directSetCoin(math.floor(value))
end

FightRouge2CoinMgr.CoinDelay = 0.5

function FightRouge2CoinMgr:onCoinDone()
	self:directSetCoin(self.targetValue)

	self.coinTweenId = nil

	gohelper.setActive(self.coinAddEffectGo, false)
	gohelper.setActive(self.coinSubEffectGo, false)
	TaskDispatcher.runDelay(self.hideCoinByAnim, self, FightRouge2CoinMgr.CoinDelay)
end

FightRouge2CoinMgr.HideDuration = 0.5

function FightRouge2CoinMgr:hideCoinByAnim()
	self.hideTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.coinInnerRoot, 1, 0, FightRouge2CoinMgr.HideDuration, self.onHideTweenDone, self)
end

function FightRouge2CoinMgr:onHideTweenDone()
	self.hideTweenId = nil

	self:hideCoin()
end

function FightRouge2CoinMgr:clearCoinTween()
	if self.coinTweenId then
		ZProj.TweenHelper.KillById(self.coinTweenId)

		self.coinTweenId = nil
	end

	if self.hideTweenId then
		ZProj.TweenHelper.KillById(self.hideTweenId)

		self.hideTweenId = nil
	end
end

function FightRouge2CoinMgr:getParamValue(key)
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(key)

	return value or 0
end

function FightRouge2CoinMgr:destroy()
	self:clearCoinTween()
	TaskDispatcher.cancelTask(self.hideCoin, self)

	if self.revivalClick then
		self.revivalClick:RemoveClickListener()

		self.revivalClick = nil
	end

	if self.tipClick then
		self.tipClick:RemoveClickListener()

		self.tipClick = nil
	end

	if self.revivalLoader then
		self.revivalLoader:dispose()

		self.revivalLoader = nil
	end

	if self.coinLoader then
		self.coinLoader:dispose()

		self.coinLoader = nil
	end

	self:__onDispose()
end

return FightRouge2CoinMgr
