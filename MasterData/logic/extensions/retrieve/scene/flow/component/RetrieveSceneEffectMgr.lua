-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveSceneEffectMgr.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveSceneEffectMgr", package.seeall)

local M = class("RetrieveSceneEffectMgr", ISceneFlowComp)
local kMainTextST = UnityEngine.Shader.PropertyToID("_BaseMap_ST")
local kMaxNumber = 4
local kLuckyFlag = "2436"
local kShowSceneTimeline = "cam_chouka_001_p"
local kEenterAnim = "enter"
local kLoopAnim = "loop"
local kRetrieveKey = "RetrieveKey"

function M:onEnterDone()
	local curScene = SceneMgr.instance:getCurScene()

	if not curScene then
		return
	end

	self._phoneTimelineGo = curScene.stage:getGoList(kShowSceneTimeline)[1]
	self._phoneTimline = self._phoneTimelineGo:GetComponent(typeof(Astral.GUITimelineAniLua))

	self._phoneTimline:AddListener(self._onDealTimelineEvent, self)

	local phoneAnimGo = curScene.stage:getGoList("s001_obj_dianhuaji_trigger")[1]

	self._phoneAnimComp = phoneAnimGo:GetComponent("Animation")

	local turnPageGo = curScene.stage:getGoList("turn_page_anmation")[1]

	self._turnPageTimeline = turnPageGo:GetComponent(typeof(Astral.GUITimelineAniLua))

	self._turnPageTimeline:AddListener(self._onDealTrunPageEvent, self)

	self._numberGo = {}

	for i = 1, 4 do
		local numberName = string.format("s410_obj_shuzi_%s", i)
		local numberGo = curScene.stage:getGoList(numberName)[1]

		if not numberGo or goutil.isNil(numberGo) then
			printError("无法找到绑点", numberName)

			return
		end

		local materialSetter = MaterialSetter.Get(numberGo)

		self._numberGo[i] = materialSetter

		self:_setNumber(i, 0, 0)
	end

	self._stickerSetter = {}

	for i = 1, 2 do
		local name = string.format("s410_obj_biaoqin_%s", i)
		local tempGo = curScene.stage:getGoList(name)[1]

		if not tempGo or goutil.isNil(tempGo) then
			printError("无法找到绑点", numberName)

			return
		end

		local materialSetter = MaterialSetter.Get(tempGo)

		if materialSetter then
			self._stickerSetter[i] = materialSetter
		end
	end

	self:_setEvent(true)

	self._numberMap = {}

	if RetrieveModel.instance:getIsTest() then
		RetrieveController.instance:preLoadShowRes()
	end
end

function M:_randomSticker()
	for i = 1, #self._stickerSetter do
		local tempOffset = 0.125 * math.random(0, 7)

		self._stickerSetter[i]:SetVector4(kMainTextST, Vector4.New(1, 1, tempOffset, 0))
	end
end

function M:_setNumber(index, value, offset)
	local numberMatSet = self._numberGo[index]

	if numberMatSet then
		local tempOffset = value / 10

		numberMatSet:SetVector4(kMainTextST, Vector4.New(offset, 1, tempOffset, 0))
	end
end

function M:_onDealTimelineEvent(tagName, reason)
	if tagName == "retrieve_enter" then
		self:onEnterAnimFinish()
	elseif tagName == "retrieve_loop" then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Retireve)
		self._phoneTimline:StopTimelineAni()
		self._phoneTimline:PlayAniByName(kLoopAnim)
	elseif tagName == "retrieve_shakeend" then
		-- block empty
	end
end

function M:_onDealTrunPageEvent(tagName, reson)
	local tempIndex = tonumber(string.sub(tagName, -1))

	if tempIndex and tempIndex > 0 then
		goutil.setActive(self._numberGo[tempIndex].gameObject, true)

		if #self._numberMap == kMaxNumber then
			local resultStr = ""

			for i = 1, #self._numberMap do
				resultStr = resultStr .. tostring(self._numberMap[i])
			end

			local isLucky = resultStr == kLuckyFlag

			self:_playPhoneAnim(isLucky)
		end
	end
end

function M:onEnterAnimFinish()
	local curScene = SceneMgr.instance:getCurScene()

	if curScene then
		curScene.light:setFloorState(false)
	end

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Retireve)
	self._phoneTimline:StopTimelineAni()
	self._phoneTimline:PlayAniByName(kLoopAnim)

	self._isShowAnim = false

	self:_setEnterFeature(false)
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Retrieve_Show_Phone)
end

function M:onExit()
	if self._phoneTimline then
		self._phoneTimline:RemoveListener()
	end

	self._phoneTimline = false

	RetrieveController.instance:clearCacheItemMOList()
	self:_setEvent(false)
	self:_clear()
end

function M:_clear()
	removetimer(self._moveCameraFinish, self)
	removetimer(self._waitForCameraMove, self)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Retireve)
	table.clear(self._numberMap)

	self._isShowAnim = false
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.Phone_Button_Click, self._onClickPhontButton, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Begin_Show_Lottery, self._onBeginShow, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Retrieve_FLOW_END, self._onEndLotteryFlow, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Open_Get_Role_UI, self._onOpenGetRoleUI, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.EnterShowVideoFinish, self._onEnterVideoFinish, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Begin_Show_Lottery, self._onBeginShow, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Phone_Button_Click, self._onClickPhontButton, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Retrieve_FLOW_END, self._onEndLotteryFlow, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Open_Get_Role_UI, self._onOpenGetRoleUI, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.EnterShowVideoFinish, self._onEnterVideoFinish, self)
	end
end

function M:_onClickPhontButton(evt, hitGo)
	if not hitGo or goutil.isNil(hitGo) then
		return
	end

	if self._isShowAnim then
		if enableLog then
			printInfo("Retrieve .. is play water video")
		end

		return
	end

	local len = #self._numberMap

	if len >= kMaxNumber then
		return
	end

	local parentTran = hitGo.transform.parent
	local animaCom = false
	local hitGoName = hitGo.name

	if string.match(hitGoName, "anjian_call") then
		if self._phoneAnimComp then
			self._phoneAnimComp:Stop()
			self._phoneAnimComp:Play("dianhuaji_anjian12")
		end

		CriwareAudioFacade.instance:playSEByName("ui_zhaomu_anjianbohao")
		self:_playPhoneAnim(false)
	elseif string.match(hitGoName, "anjian_return") then
		local tempIndex = #self._numberMap

		if tempIndex > 0 then
			self:_setNumber(tempIndex, 0, 0)
		end

		if self._phoneAnimComp then
			self._phoneAnimComp:Stop()
			self._phoneAnimComp:Play("dianhuaji_anjian10")
		end

		self._numberMap[tempIndex] = nil

		CriwareAudioFacade.instance:playSEByName("ui_zhaomu_anjianfanhui")
	else
		for i = 0, 9 do
			local numFlag = string.format("anjian_%s", i)

			if string.ends(hitGoName, numFlag) then
				local seName = string.format("ui_zhaomu_anjian%s", i)

				CriwareAudioFacade.instance:playSEByName(seName)

				local animName = false

				animName = i == 0 and "dianhuaji_anjian11" or string.format("dianhuaji_anjian%s", i)

				table.insert(self._numberMap, i)

				local tempIndex = #self._numberMap

				self:_setNumber(tempIndex, i, 1)
				goutil.setActive(self._numberGo[tempIndex].gameObject, false)

				if self._phoneAnimComp and animName then
					self._phoneAnimComp:Stop()
					self._phoneAnimComp:Play(animName)
				end

				local fanyeName = string.format("fanye_%s", tempIndex)

				self._turnPageTimeline:PlayAniByName(fanyeName)
			end
		end
	end
end

function M:_playPhoneAnim(isLucky)
	self._isShowAnim = true

	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Show_Jump_View, isLucky)
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Retrieve_Show_Phone_End)
end

function M:_onBeginShow(evt, lotteryResult)
	ViewMgr.instance:close(ViewName.RetrieveMainViewViewPresentor)
	ViewMgr.instance:open(ViewName.RetrieveJumpViewViewPresentor, lotteryResult)
	RetrieveController.instance:removeAllHero()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Retireve)

	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local curScene = SceneMgr.instance:getCurScene()

		if curScene then
			curScene.stage:activeSceneByName(RetrieveEnum.SceneNameMap.Show, SceneLayer.TransparentFX_Value)
			curScene.light:setFloorState(true)
		end
	end

	self:_setEnterFeature(true)

	for i = 1, 4 do
		self:_setNumber(i, 0, 0)
	end

	self:_randomSticker()
	ViewMgr.instance:open(ViewName.RetrieveDialView)
	self._phoneTimline:StopTimelineAni()
	self._phoneTimline:PlayAniByName(kEenterAnim)
end

function M:_onEndLotteryFlow(evt, isSingleModel)
	self:_clear()
	VirtualCameraMgr.instance:setBlendDuration(0)
	self._phoneTimline:ClearAllBinding()
	self._phoneTimline:StopTimelineAni()
	self._phoneTimline:SetAniTime(0)

	if isSingleModel then
		RetrieveController.instance:clearCacheItemMOList()
		RetrieveController.instance:jumpToMainRetrieve()

		return
	end

	RetrieveController.instance:swtich2Result()
end

function M:_onOpenGetRoleUI(evt)
	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local curScene = SceneMgr.instance:getCurScene()

		if curScene then
			curScene.stage:activeSceneByName("nil")
		end
	end
end

function M:_onEnterVideoFinish()
	self:onEnterAnimFinish()
end

function M:_setEnterFeature(enable)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.SSPR, enable, kRetrieveKey)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.HBAO, enable, kRetrieveKey)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.WATER_PLANAR_REFLECTION, enable, kRetrieveKey)
end

return M
