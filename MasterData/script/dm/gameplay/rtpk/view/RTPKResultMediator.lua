-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKResultMediator.lua

RTPKResultMediator = class("RTPKResultMediator", DmPopupViewMediator, _M)

RTPKResultMediator:has("_rtpkSystem", {
	is = "r"
}):injectWith("RTPKSystem")

function RTPKResultMediator:initialize()
	super.initialize(self)
end

function RTPKResultMediator:dispose()
	super.dispose(self)
end

function RTPKResultMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._aniNode = self._main:getChildByName("animNode")
	self._aniNodeUp = self._main:getChildByName("animNodeUp")
	self._gradeUpImg = self._main:getChildByName("Image_gradeup")
	self._tipsText = self._main:getChildByName("Text_tips")

	self._gradeUpImg:setVisible(false)
	self._tipsText:setVisible(false)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 245, 216, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(254, 248, 174, 255)
		}
	}

	self._gradeUpImg:getChildByName("Text_1"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function RTPKResultMediator:enterWithData(data)
	self._rtpk = self._rtpkSystem:getRtpk()

	self:mapEventListeners()
	self:setupView(data)
end

function RTPKResultMediator:mapEventListeners()
	return
end

function RTPKResultMediator:setupView(data)
	local win = data.win
	local addScore = data.increase
	local curScore = self._rtpk:getCurScore()
	local newScore = self._rtpk:getCurScore() + addScore
	local curGradeData = self._rtpk:getCurGrade()
	local newGradeData = self._rtpkSystem:getGradeConfigByScore(newScore)
	local text = self._main:getChildByName("Text_3")

	if win then
		text:setString(Strings:get("RTPK_AddScore"))
		AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Win")
		self._main:setScaleY(0)

		local scaleAct = cc.ScaleTo:create(0.16666666666666666, 1)
		local fadeInAct = cc.FadeIn:create(0.16666666666666666)
		local action = cc.Spawn:create(scaleAct, fadeInAct)
		local call = cc.CallFunc:create(function()
			local anim = cc.MovieClip:create("tiaozhanchenggong_tiaozhanchenggongeff")

			anim:addTo(self._aniNode):offset(0, -30)
			anim:gotoAndPlay(1)

			if newGradeData.Id > curGradeData.Id then
				self._gradeUpImg:setVisible(true)

				local upAnim = cc.MovieClip:create("duanweitisheng_tiaozhanchenggongeff")

				upAnim:addTo(self._aniNodeUp):offset(0, -20)

				for i = 1, 2 do
					local oldIconNode = upAnim:getChildByName("oldicon" .. i)
					local curGradeIcon = IconFactory:createRTPKGradeIcon(curGradeData.Id, {
						useAnim = true
					})

					curGradeIcon:addTo(oldIconNode):offset(0, 20)
				end

				for i = 1, 4 do
					local newIconNode = upAnim:getChildByName("newicon" .. i)
					local newGradeIcon = IconFactory:createRTPKGradeIcon(newGradeData.Id, {
						useAnim = true
					})

					newGradeIcon:addTo(newIconNode):offset(0, 20)
				end

				upAnim:addCallbackAtFrame(30, function()
					upAnim:stop()
				end)
			else
				local mc_nowGradeIcon = anim:getChildByName("mc_gradeIcon")
				local nowGradeIcon = IconFactory:createRTPKGradeIcon(curGradeData.Id, {
					useAnim = true
				})

				nowGradeIcon:addTo(mc_nowGradeIcon):offset(0, 20)
			end

			anim:addCallbackAtFrame(120, function()
				anim:stop()
			end)
		end)

		self._main:runAction(cc.Sequence:create(action, call))
	else
		text:setString(Strings:get("RTPK_EndGame_TextLose"))
		AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Over")
		self._main:setScaleY(0)

		local scaleAct = cc.ScaleTo:create(0.16666666666666666, 1)
		local fadeInAct = cc.FadeIn:create(0.16666666666666666)
		local action = cc.Spawn:create(scaleAct, fadeInAct)
		local call = cc.CallFunc:create(function()
			local anim = cc.MovieClip:create("tiaozhanshibai_tiaozhanchenggongeff")

			anim:addTo(self._aniNode):offset(0, -30)

			local mc_nowGradeIcon = anim:getChildByName("mc_gradeIcon")
			local nowGradeIcon = IconFactory:createRTPKGradeIcon(newGradeData.Id, {
				useAnim = true
			})

			nowGradeIcon:addTo(mc_nowGradeIcon):offset(0, 20)
			anim:addCallbackAtFrame(55, function()
				anim:stop()
			end)
		end)

		self._main:runAction(cc.Sequence:create(action, call))
	end

	local addScoreText = self._main:getChildByName("Text_scoreadd")
	local addScore = data.increase

	addScoreText:setString((addScore > 0 or nil) and ("+" .. addScore or addScore))

	if addScore > 0 then
		addScoreText:setTextColor(cc.c3b(178, 232, 100))
	else
		addScoreText:setTextColor(cc.c3b(251, 74, 78))
	end

	addScoreText:setPositionX(568)

	local isDouble = data.double

	if isDouble then
		addScoreText:setString("+" .. addScore .. Strings:get("RTPK_DoubleScore_UI02"))
		addScoreText:setPositionX(589)
		self._main:getChildByName("Text_3"):setFontSize(24)
	end

	self._main:getChildByName("Text_3"):setPositionX(addScoreText:getPositionX() - addScoreText:getContentSize().width - 5)

	local scoreText = self._main:getChildByName("Text_score")
	local isMaxGrade = self._rtpk:isMaxGrade(newGradeData.Id)

	if isMaxGrade then
		scoreText:setString(Strings:get("RTPK_ScoreShow02", {
			cur = self._rtpk:getCurScore() + addScore
		}))
	else
		scoreText:setString(Strings:get("RTPK_ScoreShow01", {
			cur = self._rtpk:getCurScore() + addScore,
			total = newGradeData.ScoreHigh
		}))
	end

	if data.outOfTime then
		self._gradeUpImg:setVisible(false)
		self._tipsText:setVisible(true)
	end
end

function RTPKResultMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self._rtpkSystem:switchRTPKMainView()
end
