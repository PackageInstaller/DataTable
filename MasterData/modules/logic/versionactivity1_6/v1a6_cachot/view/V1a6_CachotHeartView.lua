-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeartView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeartView", package.seeall)

local V1a6_CachotHeartView = class("V1a6_CachotHeartView", BaseView)

function V1a6_CachotHeartView:ctor(rootPath)
	self._rootPath = rootPath or ""

	V1a6_CachotHeartView.super.ctor(self)
end

function V1a6_CachotHeartView:onInitView()
	self._rootGo = gohelper.findChild(self.viewGO, self._rootPath)

	gohelper.setActive(self._rootGo, true)

	self._gotipsbg = gohelper.findChild(self._rootGo, "#go_tipsbg")
	self._txttitle = gohelper.findChildTextMesh(self._rootGo, "#go_tipsbg/title")
	self._gotipsitem = gohelper.findChild(self._rootGo, "#go_tipsbg/nowDes/#go_tipsitem")
	self._btnheartclick = gohelper.findChildButtonWithAudio(self._rootGo, "#btn_heartclick")
	self._slider = gohelper.findChildSlider(self._rootGo, "#slider_heart")
	self._txtnum = gohelper.findChildTextMesh(self._rootGo, "#slider_heart/Handle Slide Area/Handle/#txt_num")
	self._imagelight = gohelper.findChildImage(self._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light")
	self._golighteffectyellow = gohelper.findChild(self._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/yellow")
	self._golighteffectorange = gohelper.findChild(self._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/orange")
	self._golighteffectblue = gohelper.findChild(self._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/blue")
	self._gonexttitle = gohelper.findChild(self._rootGo, "#go_tipsbg/nextTitle")
	self._txtnextNum = gohelper.findChildTextMesh(self._rootGo, "#go_tipsbg/nextTitle/nextNum")
	self._gonextDes = gohelper.findChild(self._rootGo, "#go_tipsbg/nextDes")
	self._gonextDesItem = gohelper.findChild(self._rootGo, "#go_tipsbg/nextDes/#go_tipsitem")
	self._gopretitle = gohelper.findChild(self._rootGo, "#go_tipsbg/preTitle")
	self._txtpreNum = gohelper.findChildTextMesh(self._rootGo, "#go_tipsbg/preTitle/preNum")
	self._gopreDes = gohelper.findChild(self._rootGo, "#go_tipsbg/preDes")
	self._gopreDesItem = gohelper.findChild(self._rootGo, "#go_tipsbg/preDes/#go_tipsitem")
end

function V1a6_CachotHeartView:addEvents()
	self._btnheartclick:AddClickListener(self.showHideTips, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshInfo, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateHeart, self._refreshInfo, self)
end

function V1a6_CachotHeartView:removeEvents()
	self._btnheartclick:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshInfo, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateHeart, self._refreshInfo, self)
end

function V1a6_CachotHeartView:onOpen()
	gohelper.setActive(self._golighteffectyellow, false)
	gohelper.setActive(self._golighteffectorange, false)
	gohelper.setActive(self._golighteffectblue, false)
	self:_refreshInfo(true)
end

function V1a6_CachotHeartView:_refreshInfo(isFirst)
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	local heartNum = self._rogueInfo.heart
	local co = V1a6_CachotConfig.instance:getHeartConfig(heartNum)

	self._txttitle.text = co.title

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if isFirst or not self._nowHeart then
		self:_setValue(heartNum, true)

		self._nowHeart = heartNum
	elseif self._nowHeart ~= heartNum then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowHeart, heartNum, 0.5, self._setValue, self._onTweenHeartFinish, self)
	end

	local datas = self:_getDesData(co.desc)

	gohelper.CreateObjList(self, self.onDesItemCreate, datas, self._gotipsitem.transform.parent.gameObject, self._gotipsitem)

	local preCo = lua_rogue_heartbeat.configDict[co.id - 1]
	local nextCo = lua_rogue_heartbeat.configDict[co.id + 1]

	if preCo then
		local arr = string.splitToNumber(preCo.range, "#")

		self._txtpreNum.text = formatLuaLang("v1a6_cachot_heart_lt", arr[2])

		gohelper.setActive(self._gopretitle, true)
		gohelper.setActive(self._gopreDes, true)

		local preDatas = self:_getDesData(preCo.desc)

		gohelper.CreateObjList(self, self.onDesItemCreate, preDatas, self._gopreDesItem.transform.parent.gameObject, self._gopreDesItem)
	else
		gohelper.setActive(self._gopretitle, false)
		gohelper.setActive(self._gopreDes, false)
	end

	if nextCo then
		local arr = string.splitToNumber(nextCo.range, "#")

		self._txtnextNum.text = formatLuaLang("v1a6_cachot_heart_gt", arr[1])

		gohelper.setActive(self._gonexttitle, true)
		gohelper.setActive(self._gonextDes, true)

		local nextDatas = self:_getDesData(nextCo.desc)

		gohelper.CreateObjList(self, self.onDesItemCreate, nextDatas, self._gonextDesItem.transform.parent.gameObject, self._gonextDesItem)
	else
		gohelper.setActive(self._gonexttitle, false)
		gohelper.setActive(self._gonextDes, false)
	end
end

function V1a6_CachotHeartView:_getDesData(desc)
	return (not string.nilorempty(desc) or nil) and string.split(desc, "\n")
end

function V1a6_CachotHeartView:_onTweenHeartFinish()
	self._tweenId = nil
end

function V1a6_CachotHeartView:_setValue(heartNum, isForce)
	heartNum = math.floor(heartNum)

	local co = V1a6_CachotConfig.instance:getHeartConfig(heartNum)
	local constStr = lua_rogue_const.configDict[V1a6_CachotEnum.Const.HeartConst].value
	local arr = string.splitToNumber(constStr, "#")

	self._txtnum.text = heartNum

	self._slider:SetValue((heartNum - arr[1]) / (arr[2] - arr[1]))

	local icon, effect

	if arr[3] > co.id then
		icon = "v1a6_cachot_img_heartblue"
		effect = self._golighteffectblue
	elseif arr[3] == co.id then
		icon = "v1a6_cachot_img_heartyellow"
		effect = self._golighteffectyellow
	elseif arr[3] < co.id then
		icon = "v1a6_cachot_img_heartorange"
		effect = self._golighteffectorange
	end

	if not isForce and self._nowIcon ~= icon then
		gohelper.setActive(effect, false)
		gohelper.setActive(effect, true)
	end

	self._nowIcon = icon
	self._nowHeart = heartNum

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagelight, icon)
end

function V1a6_CachotHeartView:onDesItemCreate(obj, data, index)
	local text = gohelper.findChildTextMesh(obj, "desc")

	text.text = data
end

function V1a6_CachotHeartView:_onTouchScreen()
	if gohelper.isMouseOverGo(self._btnheartclick) then
		return
	end

	gohelper.setActive(self._gotipsbg, false)
end

function V1a6_CachotHeartView:showHideTips()
	local isShow = not self._gotipsbg.activeSelf

	gohelper.setActive(self._gotipsbg, isShow)
end

function V1a6_CachotHeartView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId, false)

		self._tweenId = nil
	end
end

return V1a6_CachotHeartView
