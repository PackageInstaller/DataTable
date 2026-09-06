-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectBlessingLionView.lua

module("logic.extensions.birthdaywishes.view.CollectBlessingLionView", package.seeall)

local CollectBlessingLionView = class("CollectBlessingLionView", ViewComponent)

function CollectBlessingLionView:ctor()
	CollectBlessingLionView.super.ctor(self)
end

function CollectBlessingLionView:unbindEvents()
	CollectBlessingLionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._goLion)
	GameUtil.rmClickHandler(self._btnClose)
end

function CollectBlessingLionView:bindEvents()
	CollectBlessingLionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._goLion, self._onClickLion, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function CollectBlessingLionView:buildUI()
	CollectBlessingLionView.super.buildUI(self)

	self._txtTip = self:getTxt("txtTip")
	self._txtWish = self:getTxt("panel/txtWish")
	self._lionCon = self:getGo("panel/lionParent")
	self._goLion = self:getGo("panel/lion")
	self._btnClose = self:getBtn("btnClose")
	self._panel = self:getGo("panel")
	self._imgLion = self:getGo("panel"):GetComponent(typeof(UnityEngine.UI.RawImage))
end

function CollectBlessingLionView:onExit()
	CollectBlessingLionView.super.onExit(self)
	self:_removeCellEff(self._panel)
	self:_clearRole()
end

function CollectBlessingLionView:onEnter()
	CollectBlessingLionView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cfgs = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(self._activityId)
	self._isClick = false
	self._txtTip.text = "点击狮头查看吉签吧！"

	GameUtil.SetActive(self._txtWish, false)

	self._imgLion.enabled = false

	self:_loadRole()
end

function CollectBlessingLionView:_loadRole()
	local spinePath = "effect/prefabs/story/story_xingshicifu/xingshicifu/xingshicifu-ui_p.prefab"
	local pathTable = {}

	table.insert(pathTable, spinePath)

	self._lion = UIEffectManager.instance:playEffect(self, pathTable, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		self._lionSkeletonGraphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
		self._lionSkeletonGraphic.startingAnimation = "idle2"

		self._lionSkeletonGraphic.AnimationState:SetAnimation(0, "idle2", true)
	end)

	self._lion:setParent(self._lionCon.transform)
	self._lion:setScale(0.8)
end

function CollectBlessingLionView:_clearRole()
	if self._lion then
		UIEffectManager.instance:stopEffect(self._lion)

		self._lion = nil
	end
end

function CollectBlessingLionView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function CollectBlessingLionView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function CollectBlessingLionView:_onClickLion()
	if self._isClick then
		return
	end

	local function callback()
		local wishWordCfgs = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._cfgs.wishesTextPlan)
		local randomIdx = math.random(1, #wishWordCfgs)

		self._txtWish.text = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgsById(self._cfgs.wishesTextPlan, randomIdx).desc
		self._txtTip.text = "点击空白处关闭"

		GameUtil.SetActive(self._txtWish, true)

		self._imgLion.enabled = true

		local effectPath = "20230120/xingshicifu/fx_ui_xscf_shizibaokai.prefab"

		self:_playCellEff(self._panel, effectPath, 0, 0, nil, nil)
		self:_clearRole()

		self._isClick = true
	end

	RoleObjectPool.instance:playAnimation(self._lionSkeletonGraphic, "1", false, callback, true)
end

function CollectBlessingLionView:_onClickClose()
	if self._isClick then
		local giftType = BirthdayWishesModel.instance:getGiftType()

		BirthdayWishesController.instance:csGetBirthdayWishesGiftOpenReq(self._activityId, giftType)
		self:close()
	end
end

return CollectBlessingLionView
