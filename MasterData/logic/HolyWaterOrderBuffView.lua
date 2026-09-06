-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderBuffView.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderBuffView", package.seeall)

local HolyWaterOrderBuffView = class("HolyWaterOrderBuffView", ViewComponent)

function HolyWaterOrderBuffView:ctor()
	HolyWaterOrderBuffView.super.ctor(self)
end

function HolyWaterOrderBuffView:buildUI()
	HolyWaterOrderBuffView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._itemList = {}

	for i = 1, 3 do
		local item = {}
		local go = self:getGo("moveNode/item" .. i)

		item.go = go
		item.buffIcon = goutil.findChild(go, "node/buffIcon")
		item.selectGo = goutil.findChild(go, "node/selectGo")
		item.txtName = goutil.findChildTextComponent(go, "node/txtName")
		item.txtName2 = goutil.findChildTextComponent(go, "node/txtName2")
		item.txtDesc = goutil.findChildTextComponent(go, "node/txtDesc")
		item.btn = Framework.ButtonAdapter.GetFrom(go, "node")

		table.insert(self._itemList, item)
	end
end

function HolyWaterOrderBuffView:bindEvents()
	HolyWaterOrderBuffView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)

	for i, v in ipairs(self._itemList) do
		v.btn:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function HolyWaterOrderBuffView:unbindEvents()
	HolyWaterOrderBuffView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnArrow:RemoveClickListener()

	for i, v in ipairs(self._itemList) do
		v.btn:RemoveClickListener()
	end
end

function HolyWaterOrderBuffView:onEnter()
	HolyWaterOrderBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._isPopupState = true
	self._difficultLevelNum = 3

	goutil.setActive(self._btnHide.gameObject, true)
	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, -450, 80)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
	self:_initBuffs()
end

function HolyWaterOrderBuffView:onExit()
	HolyWaterOrderBuffView.super.onExit(self)
end

function HolyWaterOrderBuffView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-450, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function HolyWaterOrderBuffView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-450, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-450, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function HolyWaterOrderBuffView:_onClickLevel(index)
	self._difficultLevelNum = index

	for i, v in ipairs(self._itemList) do
		goutil.setActive(v.selectGo, self._difficultLevelNum == i)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderSelectBuff, self._difficultLevelNum)
end

function HolyWaterOrderBuffView:_initBuffs()
	local cfgStage = HolyWaterOrderConfig.instance:getStageCfg(self._activityId, self._stageId)

	if cfgStage then
		for i, v in ipairs(self._itemList) do
			local cfgBuff = HolyWaterOrderConfig.instance:getBuffCfg(cfgStage.buffPlanId, i)

			if cfgBuff then
				uGuiUtil.setSpriteToImage(v.buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))

				v.txtName.text = cfgBuff.buffName
				v.txtName2.text = cfgBuff.buffName
				v.txtDesc.text = cfgBuff.buffDesc

				goutil.setActive(v.selectGo, self._difficultLevelNum == i)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HolyWaterOrderSelectBuff, self._difficultLevelNum)
end

return HolyWaterOrderBuffView
