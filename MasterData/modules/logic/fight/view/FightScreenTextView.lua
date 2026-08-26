-- chunkname: @modules/logic/fight/view/FightScreenTextView.lua

module("modules.logic.fight.view.FightScreenTextView", package.seeall)

local FightScreenTextView = class("FightScreenTextView", FightBaseView)

function FightScreenTextView:onConstructor(paramsArr, duration)
	self.duration = duration
	self.paramsArr = paramsArr
	self.textId = paramsArr[1]

	local param2 = paramsArr[2]

	self.fontSize = not string.nilorempty(param2) and tonumber(param2) or 56

	local param3 = paramsArr[3]

	self.color = not string.nilorempty(param3) and param3 or "ffffff"

	local param4 = paramsArr[4]

	self.enterFade = not string.nilorempty(param4) and tonumber(param4) or 0

	local param5 = paramsArr[5]

	self.exitFade = not string.nilorempty(param5) and tonumber(param5) or 0
end

function FightScreenTextView:onInitView()
	self.text = gohelper.findChildText(self.viewGO, "root/txt_contentcn")
	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightScreenTextView:onOpen()
	self.text.fontSize = self.fontSize
	self.text.text = "<color=#" .. self.color .. ">" .. luaLang(self.textId) .. "</color>"

	if self.enterFade > 0 then
		self.tweenComp:DoFade(self.text, 0, 1, self.enterFade)
	end

	if self.exitFade > 0 then
		self:com_registTimer(self.fadeOut, self.duration - self.exitFade)
	end
end

function FightScreenTextView:fadeOut()
	self.tweenComp:DoFade(self.text, 1, 0, self.exitFade)
end

return FightScreenTextView
