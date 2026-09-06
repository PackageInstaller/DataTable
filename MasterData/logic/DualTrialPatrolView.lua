-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialPatrolView.lua

module("logic.extensions.dualtrial.view.DualTrialPatrolView", package.seeall)

local DualTrialPatrolView = class("DualTrialPatrolView", ViewComponent)

function DualTrialPatrolView:ctor()
	DualTrialPatrolView.super.ctor(self)
end

function DualTrialPatrolView:unbindEvents()
	DualTrialPatrolView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DualTrialPatrolView:bindEvents()
	DualTrialPatrolView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._showNextView, self)
end

function DualTrialPatrolView:buildUI()
	DualTrialPatrolView.super.buildUI(self)

	self._scrollbg1 = self:getGo("scrollbg1"):GetComponent(goutil.Type_UIImage)
	self._scrollbg1BigBG = self:getGo("scrollbg1"):GetComponent("ImageBigBG")
	self._scrollbg2 = self:getGo("scrollbg2"):GetComponent(goutil.Type_UIImage)
	self._scrollbg2BigBG = self:getGo("scrollbg2"):GetComponent("ImageBigBG")
	self._scrollbg3 = self:getGo("scrollbg3"):GetComponent(goutil.Type_UIImage)
	self._scrollbg3BigBG = self:getGo("scrollbg3"):GetComponent("ImageBigBG")
	self._pos_1 = self:getGo("pos_1")
	self._pos_2 = self:getGo("pos_2")
	self._pos_3 = self:getGo("pos_3")
	self._showPalyer = self:getGo("showPalyer")
	self._bubble = self:getGo("bubble")
	self._btnClose = self:getGo("btnClose")
end

function DualTrialPatrolView:onExit()
	DualTrialPatrolView.super.onExit(self)

	if self._tweenMap then
		for _, tween in pairs(self._tweenMap) do
			tween:Kill(false)
		end

		self._tweenMap = nil
	end

	if self._url1 then
		removeresl(self._url1, self._onResloadFinish1, self)

		self._url1 = nil
	end

	if self._res1 then
		self._res1:Release()

		self._res1 = nil
	end

	if self._url2 then
		removeresl(self._url2, self._onResloadFinish2, self)

		self._url2 = nil
	end

	if self._res2 then
		self._res2:Release()

		self._res2 = nil
	end

	if self._url3 then
		removeresl(self._url3, self._onResloadFinish3, self)

		self._url3 = nil
	end

	if self._res3 then
		self._res3:Release()

		self._res3 = nil
	end

	self:_removeMaterial()
	removetimer(self._showNextView, self)
end

function DualTrialPatrolView:onEnter()
	DualTrialPatrolView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self:_initMaterial()
	self:_playAni()
	settimer(5, self._showNextView, self, true)
	settimer(3, self._playSecondAni, self, true)
end

function DualTrialPatrolView:_playSecondAni()
	goutil.setActive(self._showPalyer, true)
	goutil.setActive(self._bubble, true)

	if self._bigImg1 then
		RoleObjectPool.instance:playAnimation(self._bigImg1, "idle", true)
	end

	if self._bigImg2 then
		RoleObjectPool.instance:playAnimation(self._bigImg2, "idle", true)
	end

	if self._bigImg3 then
		RoleObjectPool.instance:playAnimation(self._bigImg3, "idle", true)
	end

	if self._tweenMap then
		for _, tween in pairs(self._tweenMap) do
			tween:Kill(false)
		end

		self._tweenMap = nil
	end
end

function DualTrialPatrolView:_showNextView()
	self:close()
	DualTrialController.instance:onepEventView(self._activityId, false)
end

function DualTrialPatrolView:_initMaterial()
	self._scrollBg1Mat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._scrollbg1.material = self._scrollBg1Mat1

	uGuiUtil.setSpriteToImage(self._scrollbg1.gameObject, uGuiUtil.SpriteType.BigBg, "ui/bigbg/views/dualtrial/board_sssp_yuanjing.png")
	self._scrollbg1BigBG:SetWrapMode(UnityEngine.TextureWrapMode.Repeat)

	self._scrollBg1Mat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._scrollbg2.material = self._scrollBg1Mat2

	uGuiUtil.setSpriteToImage(self._scrollbg2.gameObject, uGuiUtil.SpriteType.BigBg, "ui/bigbg/views/dualtrial/board_sssp_zhongjing.png")
	self._scrollbg2BigBG:SetWrapMode(UnityEngine.TextureWrapMode.Repeat)

	self._scrollBg1Mat3 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._scrollbg3.material = self._scrollBg1Mat3

	uGuiUtil.setSpriteToImage(self._scrollbg3.gameObject, uGuiUtil.SpriteType.BigBg, "ui/bigbg/views/dualtrial/board_sssp_jinjing.png")
	self._scrollbg3BigBG:SetWrapMode(UnityEngine.TextureWrapMode.Repeat)

	self._initMat = true
end

function DualTrialPatrolView:_removeMaterial()
	self._scrollbg1.material = nil
	self._scrollbg2.material = nil
	self._scrollbg3.material = nil

	goutil.destroy(self._scrollBg1Mat1)
	goutil.destroy(self._scrollBg1Mat2)
	goutil.destroy(self._scrollBg1Mat3)

	self._scrollBg1Mat1 = nil
	self._scrollBg1Mat2 = nil
	self._scrollBg1Mat3 = nil

	uGuiUtil.clearImage(self._scrollbg1)
	uGuiUtil.clearImage(self._scrollbg2)
	uGuiUtil.clearImage(self._scrollbg3)

	self._bigImg1 = nil
	self._bigImg2 = nil
	self._bigImg3 = nil
	self._initMat = false
end

function DualTrialPatrolView:_playAni()
	self:_doTweenScrollAni(self._scrollBg1Mat1, 6)
	self:_doTweenScrollAni(self._scrollBg1Mat2, 7)
	self:_doTweenScrollAni(self._scrollBg1Mat3, 7)

	self._url1 = GameUrl.getSpineUIUrl("zhiren_aoqi")

	getres(self._url1, self._onResloadFinish1, self, ResType.AssetBundle, true)

	self._url2 = GameUrl.getSpineUIUrl("zhiren_shuangshengbai")

	getres(self._url2, self._onResloadFinish2, self, ResType.AssetBundle, true)

	self._url3 = GameUrl.getSpineUIUrl("zhiren_shuangshenghei")

	getres(self._url3, self._onResloadFinish3, self, ResType.AssetBundle, true)
	goutil.setActive(self._showPalyer, false)
	goutil.setActive(self._bubble, false)
end

function DualTrialPatrolView:_doTweenScrollAni(scrMat, duration)
	self._tweenMap = self._tweenMap or {}
	self._vect2Map = self._vect2Map or {}

	local tween = self._tweenMap[scrMat]

	if tween then
		tween:Kill(false)

		self._tweenMap[scrMat] = nil
	end

	if not self._vect2Map[scrMat] then
		local vect2 = Vector2.zero

		tween = TweenUtil.ValueTo(0, 1, duration, function(val)
			vect2:Set(val, 0)
			scrMat:SetTextureOffset("_MainTex", vect2)
		end, function()
			self:_doTweenScrollAni(scrMat, duration)
		end, self, DG.Tweening.Ease.Linear)
		self._vect2Map[scrMat] = vect2
		self._tweenMap[scrMat] = tween
	end
end

function DualTrialPatrolView:_onResloadFinish1(res)
	local resPath = self._url1

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._res1 = res

		self._res1:Retain()

		local prefab = self._res1:GetMainAsset()

		if prefab then
			local bigImg = goutil.clone(prefab)

			goutil.clearChildren(self._pos_1)
			goutil.addChildToParent(bigImg, self._pos_1)
			GameUtil.setAnchoredPos(bigImg, 0, 0)
			GameUtil.setLocalScale(bigImg, 1, 1, 1)
			RoleObjectPool.instance:playAnimation(bigImg, "run", true)

			self._bigImg1 = bigImg
		end
	end
end

function DualTrialPatrolView:_onResloadFinish2(res)
	local resPath = self._url2

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._res2 = res

		self._res2:Retain()

		local prefab = self._res2:GetMainAsset()

		if prefab then
			local bigImg = goutil.clone(prefab)

			goutil.clearChildren(self._pos_2)
			goutil.addChildToParent(bigImg, self._pos_2)
			GameUtil.setAnchoredPos(bigImg, 0, 0)
			GameUtil.setLocalScale(bigImg, 1, 1, 1)
			RoleObjectPool.instance:playAnimation(bigImg, "walk", true)

			self._bigImg2 = bigImg
		end
	end
end

function DualTrialPatrolView:_onResloadFinish3(res)
	local resPath = self._url3

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._res3 = res

		self._res3:Retain()

		local prefab = self._res3:GetMainAsset()

		if prefab then
			local bigImg = goutil.clone(prefab)

			goutil.clearChildren(self._pos_3)
			goutil.addChildToParent(bigImg, self._pos_3)
			GameUtil.setAnchoredPos(bigImg, 0, 0)
			GameUtil.setLocalScale(bigImg, 1, 1, 1)
			RoleObjectPool.instance:playAnimation(bigImg, "walk", true)

			self._bigImg3 = bigImg
		end
	end
end

return DualTrialPatrolView
