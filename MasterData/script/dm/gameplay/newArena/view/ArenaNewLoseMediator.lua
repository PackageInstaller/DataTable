-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewLoseMediator.lua

ArenaNewLoseMediator = class("ArenaNewLoseMediator", DmPopupViewMediator, _M)

ArenaNewLoseMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewLoseMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local posLose = {
	{
		cc.p(333, 30)
	},
	{
		cc.p(253, 30),
		cc.p(423, 30)
	},
	{
		cc.p(163, 30),
		cc.p(333, 30),
		cc.p(503, 30)
	},
	{
		cc.p(83, 30),
		cc.p(253, 30),
		cc.p(423, 30),
		cc.p(593, 30)
	},
	{
		cc.p(-7, 30),
		cc.p(163, 30),
		cc.p(333, 30),
		cc.p(503, 30),
		cc.p(673, 30)
	}
}

function ArenaNewLoseMediator:initialize()
	super.initialize(self)
end

function ArenaNewLoseMediator:dispose()
	super.dispose(self)
end

function ArenaNewLoseMediator:onRegister()
	super.onRegister(self)
	self:setViewUI()
end

function ArenaNewLoseMediator:setViewUI()
	self._main = self:getView():getChildByFullName("main")
	self._winLayout = self._main:getChildByFullName("winLayout")

	self._winLayout:setVisible(false)

	self._loseLayout = self._main:getChildByFullName("loseLayout")

	self._loseLayout:setVisible(false)

	self.panel_win = self._winLayout:getChildByFullName("panel_win")
	self._heroPanel = self._winLayout:getChildByFullName("heroPanel")
	self._loseHeroPanel = self._loseLayout:getChildByFullName("heroPanel")

	self:bindWidget("main.loseLayout.btn_exit", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickButtonExit, self)
		}
	})
	self:bindWidget("main.loseLayout.btn_manualBattle", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickButtonBattle, self)
		}
	})
end

function ArenaNewLoseMediator:enterWithData(data)
	self._data = data

	self:showLoseView()
end

function ArenaNewLoseMediator:showLoseView(retData)
	self:showRole(false)

	local winTitle = self._loseLayout:getChildByName("winTitle")
	local winAnim = cc.MovieClip:create("shibaiz_jingjijiesuan")

	winAnim:addTo(winTitle):posite(10, -100)
	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:setScale(0.7)

	local title = ccui.ImageView:create("zhandou_txt_fail.png", ccui.TextureResType.plistType)

	title:addTo(winTitle):posite(0, 0)
	title:setScale(0.7)
	self._loseLayout:setVisible(true)
end

function ArenaNewLoseMediator:onClickButtonExit()
	self._arenaNewSystem:requestReportDetail(self._data.resultData:getId())
end

function ArenaNewLoseMediator:onClickButtonBattle()
	BattleLoader:popBattleView(self, {
		viewName = self._data.popName
	})

	if self._data.popName == "ArenaNewView" and self._data.refreshRival then
		self._arenaNewSystem:requestGainChessArena()

		local dispatcher = DmGame:getInstance()

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, dispatcher:getInjector():getInstance(self._data.popName)))
	end
end

function ArenaNewLoseMediator:showRole(isWin)
	local pos = posLose

	if isWin then
		if not self._heroPanel then
			local heroPanel = self._loseHeroPanel

			heroPanel:removeAllChildren()

			local role = self._data.battleStatist
			local _winnerId = self._data.loseId

			if isWin then
				if not RoleAnimType.kStand then
					local animName = "die"
					local once = not isWin

					if role[_winnerId] then
						local unitSummary = role[_winnerId].unitSummary
						local heroes = {}
						local master = {}

						for key, value in pairs(unitSummary) do
							local num = 0

							if value.type == "hero" then
								if value.cure then
									num = num + value.cure
								end

								if value.damage then
									num = num + value.damage
								end

								local type = ConfigReader:getDataByNameIdAndKey("RoleModel", value.model, "Type")

								if num ~= 0 and type == RoleModelType.kHero then
									local addSta = false

									for _index, _value in pairs(heroes) do
										if _value.model == value.model then
											addSta = true
											_value.num = _value.num + num
										end
									end

									if not addSta then
										heroes[#heroes + 1] = {
											model = value.model,
											num = num
										}
									end
								end
							elseif value.type == "master" then
								master[#master + 1] = {
									model = value.model
								}
							end
						end

						table.sort(heroes, function(a, b)
							return a.num > b.num
						end)

						if #heroes == 0 then
							if master[1] then
								local heroAnim = RoleFactory:createHeroAnimation(master[1].model, animName, {
									once = once
								})

								heroAnim:setAnchorPoint(cc.p(0.5, 0))
								heroAnim:addTo(heroPanel)
								heroAnim:setScale(0.65)

								local position = pos[1][1]

								heroAnim:setPosition(position)
							end
						else
							local showHeroNum = math.min(#heroes, 5)

							for i = 1, showHeroNum do
								local heroAnim, jsonPath = RoleFactory:createHeroAnimation(heroes[i].model, animName, {
									once = once
								})

								heroAnim:setAnchorPoint(cc.p(0.5, 0))
								heroAnim:addTo(heroPanel)
								heroAnim:setScale(0.65)
								heroAnim:setOpacity(0)
								heroAnim:setTag(i)

								local position = pos[showHeroNum][i]

								heroAnim:setPosition(cc.p(position.x - 30, position.y))

								local moveto = cc.MoveTo:create(0.2, cc.p(position.x, position.y))
								local spawn = cc.Spawn:create(cc.FadeIn:create(0.2), moveto)
								local seq = cc.Sequence:create(cc.DelayTime:create(i * 0.1), spawn)

								heroAnim:runAction(seq)
							end
						end
					end
				end
			end
		end
	end
end
