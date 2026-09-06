-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021teammsgView.lua

module("logic.extensions.recap2021.view.Recap2021teammsgView", package.seeall)

local Recap2021teammsgView = class("Recap2021teammsgView", TableViewComponent)

Recap2021teammsgView.View_Msg_Tag = "Recap2021teammsgView.View_Msg_Tag"
Recap2021teammsgView.Open_Tag = "Recap2021teammsgView.Open_Tag"

function Recap2021teammsgView:ctor()
	Recap2021teammsgView.super.ctor(self)

	self._effectHandlers = {}
end

function Recap2021teammsgView:unbindEvents()
	Recap2021teammsgView.super.unbindEvents(self)
	self._btnRight:RemoveClickListener()
	self._btnOpen:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._typewriter:RemoveEventHandler()
end

function Recap2021teammsgView:bindEvents()
	Recap2021teammsgView.super.bindEvents(self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnOpen:AddClickListener(self._onClickbtnOpen, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._typewriter:AddEventHandler(self._textFinish, self)
end

function Recap2021teammsgView:buildUI()
	Recap2021teammsgView.super.buildUI(self)

	self._msgRootGo = self:getGo("msgRoot")
	self._effectGo = self:getGo("unlockRoot/effect")
	self._unlockRootGo = self:getGo("unlockRoot")
	self._msgBg = self:getGo("msgBg")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "msgRoot/txtDesc")
	self._btnRight = self:getBtn("msgRoot/btnRight")
	self._btnOpen = self:getBtn("unlockRoot/btnOpen")
	self._btnLeft = self:getBtn("msgRoot/btnLeft")
	self._rolecon2Go = self:getGo("rolecon2")
	self._rolecon1Go = self:getGo("rolecon1")
	self._btnClose = self:getBtn("btnClose")
	self._typewriter = self._txtDesc.gameObject:GetComponent("TypewriterNew")
	self._scrollRect = self:getGo("msgRoot/txtDesc/tableview"):GetComponent(ComponentType.ScrollRect)
	self._photoEffect1 = PhotoEffect.Get(self._rolecon1Go)
	self._photoEffect2 = PhotoEffect.Get(self._rolecon2Go)
	self._rolecon1Go:GetComponent(typeof(UnityEngine.UI.RawImage)).material = nil
	self._rolecon2Go:GetComponent(typeof(UnityEngine.UI.RawImage)).material = nil
	self._effectGo = self:getGo("unlockRoot/btnOpen")
	self._animCon = self:getGo("animcon")
	self._typewriter.speed = 0.01
	self._viewRectTr = self.mainGO:GetComponent(goutil.Type_RectTransform)
end

function Recap2021teammsgView:onExit()
	Recap2021teammsgView.super.onExit(self)
	GlobalDispatcher:removeListener(Recap2021Agent.PM_Recap21GainLetterPrizeRes, self._PM_Recap21GainLetterPrizeRes, self)
	self._photoEffect1:clear()
	self._photoEffect2:clear()
	UIEffectManager.instance:stopEffect(self._effectHandler)
	removetimer(self._updateView, self)
end

function Recap2021teammsgView:onEnter()
	Recap2021teammsgView.super.onEnter(self)
	GlobalDispatcher:addListener(Recap2021Agent.PM_Recap21GainLetterPrizeRes, self._PM_Recap21GainLetterPrizeRes, self)
	self:_initLetterData()

	self._isOpen = GameUtil.getUserData(Recap2021teammsgView.Open_Tag)

	self:_updateView()
	self:_setRoles()

	if not self._isOpen then
		self:_playEffect()
	end
end

function Recap2021teammsgView:_initLetterData()
	local planId = Recap2021Config.instance:getCommonValue("LETTER_PLAN_ID", true)
	local cfg = Recap2021Config.instance:getLetterCfg(planId)

	self._contentList = self:_formatWord(cfg.word)
	self._maxPage = #self._contentList
	self._minPage = 1
	self._currPage = self._minPage
end

function Recap2021teammsgView:_formatWord(word)
	return string.split(word, "#")
end

function Recap2021teammsgView:_onClickbtnOpen()
	self._isOpen = true

	GameUtil.saveUserData(Recap2021teammsgView.Open_Tag, true)
	self:_playAnim()
end

function Recap2021teammsgView:_onClickbtnLeft()
	self._currPage = self._currPage - 1

	self:_updateView()
end

function Recap2021teammsgView:_onClickbtnRight()
	self._currPage = self._currPage + 1

	self:_updateView()
end

function Recap2021teammsgView:_onClickbtnClose()
	if not self._isOpen then
		FloatWordMgr.instance:show("先开启信件哦")

		return
	end

	self:close()
end

function Recap2021teammsgView:_updateView()
	goutil.setActive(self._animCon, false)
	goutil.setActive(self._unlockRootGo, not self._isOpen)
	goutil.setActive(self._msgRootGo, self._isOpen)
	goutil.setActive(self._msgBg, self._isOpen)
	goutil.setActive(self._btnRight.gameObject, self._currPage < self._maxPage)
	goutil.setActive(self._btnLeft.gameObject, self._currPage > self._minPage)
	goutil.setActive(self._tableview.gameObject, false)

	local content = self._contentList[self._currPage]

	if self._isOpen then
		self._typewriter.text = content or ""

		self:_textFinish()
	end
end

function Recap2021teammsgView:_textFinish()
	local isLast = self._currPage >= self._maxPage

	goutil.setActive(self._tableview.gameObject, isLast)

	if isLast then
		self:_setReward()
		SurveyController.instance:reportBehavior(SurveyBehaviorID.READ_MSG_RECAP2021)
	end
end

function Recap2021teammsgView:_setReward()
	self._curViewDatas = Recap2021Config.instance:getLetterPrizeCfgs()

	self:reloadData()
end

function Recap2021teammsgView:_getPath()
	return {
		cellPath = "msgRoot/tablecell",
		viewPath = "msgRoot/txtDesc/tableview"
	}
end

function Recap2021teammsgView:_updateCell(view, cell, data)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local goYlq = goutil.findChild(cell.gameObject, "ylq")
	local proxy = MaterialMgr.setCellByCfg(data.prize, goItemcon)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.prize)

	local isGain = Recap2021Model.instance:isGainLetterPrize(data.letterPrizeId)
	local isCanGain = Recap2021Model.instance:isCanGainLetterPrize(data.letterPrizeId)

	goutil.setActive(goYlq, isGain)

	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			Recap2021Controller.instance:sendPM_Recap21GainLetterPrizeReq(data.letterPrizeId)
		end)

		local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		handler = UIEffectManager.instance:playEffect(self, effName, goEffect, 0, 0, true, nil, nil, function()
			handler:setClipping(self._viewRectTr)
		end)

		handler:setParent(goEffect.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)

		handler.hideEffWhileNotOnTop = true
		self._effectHandlers[goEffect] = handler
	else
		proxy.binder:setCallBack(nil)
	end
end

function Recap2021teammsgView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local goEffect = goutil.findChild(cell.gameObject, "effect")
	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)

		self._effectHandlers[goEffect] = nil
	end
end

function Recap2021teammsgView:_PM_Recap21GainLetterPrizeRes(status)
	if status == 0 then
		self:reloadData()
	end
end

function Recap2021teammsgView:_setRoles()
	self._photoEffect1:setEffectLoadedCallback(self._loadCallBack, self)
	self._photoEffect2:setEffectLoadedCallback(self._loadCallBack, self)
	self._photoEffect1:showEffectsFullScreen({
		GameUrl.getLihuiSpineUrl("80022_liangzai_lihui")
	}, 512, 512)
	self._photoEffect1:setCameraPosition(0, 12.03, -23.96)
	self._photoEffect2:showEffectsFullScreen({
		GameUrl.getLihuiSpineUrl("80021_dachengzi_lihui")
	}, 512, 512)
	self._photoEffect2:setCameraPosition(0, 2.62, -5.29)
end

function Recap2021teammsgView:_loadCallBack(go, res)
	if string.find(res.ResPath, "80021") then
		GoUtil.PlaySpineAnim(go, "idle1", true, true)
		Framework.TransformUtil.SetLocalScale(go.transform, 1.3, 1.3, 1.3)
	else
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		Framework.TransformUtil.SetLocalScale(go.transform, 0.9, 0.9, 0.9)
	end
end

function Recap2021teammsgView:_playEffect()
	local effName = "20220401/zhounianqingzongjie/fx_ui_zhounianzongjie_xinfeng.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 117, 0)
	self._effectHandler:setScale(1)
end

function Recap2021teammsgView:_playAnim()
	goutil.setActive(self._unlockRootGo, false)

	if not self._animGo then
		self._animGo = self:getResInstance(Recap2021teammsgViewPresentor.EffectPath)

		self._animGo.transform:SetParent(self._animCon.transform)
		Framework.TransformUtil.SetLocalPos(self._animGo.transform, -78, -289, 0)
		Framework.TransformUtil.SetLocalScale(self._animGo.transform, 1, 1, 1)
		Framework.GameObjectUtil.SetLayerRecursively(self._animGo, SceneLayer.MainPlayer_Value)
		GoUtil.PlaySpineAnim(self._animGo, "xinfeng", false, true)
	end

	goutil.setActive(self._animCon, true)
	settimer(1, self._updateView, self, false)
end

return Recap2021teammsgView
