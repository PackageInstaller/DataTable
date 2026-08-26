-- chunkname: @modules/logic/fight/view/FightScreenBubbleDialogView.lua

module("modules.logic.fight.view.FightScreenBubbleDialogView", package.seeall)

local FightScreenBubbleDialogView = class("FightScreenBubbleDialogView", FightBaseView)

function FightScreenBubbleDialogView:onConstructor(paramsArr, duration, fightStepData)
	self.fightStepData = fightStepData
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

	local param7 = paramsArr[7]

	if param7 == "1" then
		self.entity = FightGameMgr.entityMgr:getById(self.fightStepData.fromId)
	end

	local param8 = paramsArr[8]

	if not string.nilorempty(param8) then
		self.offsetAnchor = string.splitToNumber(param8, ",")
	end

	local param9 = paramsArr[9]

	if not string.nilorempty(param9) then
		local skin = tonumber(param9)

		for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
			if entityData.skin == skin then
				self.entity = FightGameMgr.entityMgr:getById(entityData.id)

				break
			end
		end
	end
end

function FightScreenBubbleDialogView:onInitView()
	self.text = gohelper.findChildText(self.viewGO, "#go_Bubble/Image_Bubble/#txt_Tips")
	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightScreenBubbleDialogView:onOpen()
	self.text.fontSize = self.fontSize
	self.text.text = "<color=#" .. self.color .. ">" .. luaLang(self.textId) .. "</color>"

	if self.enterFade > 0 then
		self.tweenComp:DOFadeCanvasGroup(self.viewGO, 0, 1, self.enterFade)
	end

	if self.exitFade > 0 then
		self:com_registTimer(self.fadeOut, self.duration - self.exitFade)
	end

	if self.entity and self.entity.nameUI then
		local obj = self.entity.nameUI:getUIGO()

		if obj then
			gohelper.addChild(obj, self.viewGO)
			recthelper.setAnchor(self.viewGO.transform, 0, 0)

			if self.offsetAnchor then
				recthelper.setAnchor(self.viewGO.transform, self.offsetAnchor[1] or 0, self.offsetAnchor[2] or 0)
			end
		end
	end
end

function FightScreenBubbleDialogView:fadeOut()
	self.tweenComp:DOFadeCanvasGroup(self.viewGO, 1, 0, self.exitFade)
end

return FightScreenBubbleDialogView
