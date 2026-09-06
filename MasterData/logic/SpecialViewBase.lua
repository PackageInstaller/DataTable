-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/SpecialViewBase.lua

module("logic.extensions.challenge.view.specialviews.SpecialViewBase", package.seeall)

local SpecialViewBase = class("SpecialViewBase", ChallengeViewBase)

function SpecialViewBase:onEnter(go, cfg, params)
	SpecialViewBase.super.onEnter(self, go, cfg, params)
	self:_initJinHuaBtn()
end

function SpecialViewBase:onClickJinHua()
	if ChallengeModel.instance:canGetPrize() then
		SpecialViewBase.super.onClickJinHua(self)
	elseif ChallengeModel.instance:isPrizeGot() then
		FloatWordMgr.instance:show(lang("进化奖励已领取"))
	else
		FloatWordMgr.instance:show(lang("通过关卡二即可开启进化"))
	end
end

function SpecialViewBase:_initJinHuaBtn()
	if self._jinhuaBtn then
		local jinhuaImg = self._jinhuaBtn.gameObject:GetComponent("Image")
		local canGetPrice = ChallengeModel.instance:canGetPrize()

		if jinhuaImg then
			jinhuaImg.color = canGetPrice and Color.white or Color.black
		end
	end

	if self._jinhuaBtnEffect then
		self._jinhuaBtnEffect:SetActive(canGetPrice)
	end
end

function SpecialViewBase:_prizeGot()
	if self._jinhuaBtn then
		local jinhuaImg = self._jinhuaBtn.gameObject:GetComponent("Image")

		if jinhuaImg then
			jinhuaImg.color = Color.black
		end
	end

	if self._jinhuaBtnEffect then
		self._jinhuaBtnEffect:SetActive(false)
	end
end

function SpecialViewBase:_procBtnColor(state, btnTrans)
	local text = goutil.findChild(btnTrans, "Name"):GetComponent("Text")
	local shadow = goutil.findChild(btnTrans, "Name"):GetComponent("Shadow")
	local outline = goutil.findChild(btnTrans, "Name"):GetComponent("Outline")
	local textOrder = goutil.findChild(btnTrans, "TxtOrder"):GetComponent("Text")
	local orderShd = goutil.findChild(btnTrans, "TxtOrder"):GetComponent("Shadow")

	if state == GameEnum.ChallengeBranchState.LOCKED then
		local image = btnTrans:GetComponent("Image")

		image.color = Color.New(0, 0, 0, image.color.a)
		text.color = Color.New(0.5, 0.5, 0.5, 1)

		if shadow then
			shadow.effectColor = Color.New(0.3, 0.3, 0.3, 1)
		end

		if outline then
			outline.effectColor = Color.New(0.3, 0.3, 0.3, 1)
		end

		textOrder.color = Color.New(0.5, 0.5, 0.5, 1)

		if orderShd then
			orderShd.effectColor = Color.New(0.3, 0.3, 0.3, 1)
		end
	end
end

return SpecialViewBase
