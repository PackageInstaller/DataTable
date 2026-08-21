-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/DungeonStarRewardSign.lua

module("logic.extensions.dungeon.view.mainline.DungeonStarRewardSign", package.seeall)

local M = class("DungeonStarRewardSign")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
end

function M:buildUI()
	self._line1Img = goutil.findChildImageComponent(self.mainGO, "line1")
	self._line2Img = goutil.findChildImageComponent(self.mainGO, "line2")
	self._line3Img = goutil.findChildImageComponent(self.mainGO, "line3")
	self._canGetEffectGo = goutil.findChild(self.mainGO, "effect")
	self._normalBoxImg = goutil.findChildImageComponent(self.mainGO, "normal")
	self._normalBoxGo = goutil.findChild(self.mainGO, "normal")
	self._canGetBoxGo = goutil.findChild(self.mainGO, "receive")
end

function M:setChapterMO(chapterMO)
	self._chapterMo = chapterMO

	self:_updateRewardOverviewStatus()
end

function M:_setFillAmount()
	return
end

function M:_updateRewardOverviewStatus()
	local starCount = self._chapterMo:getStarCount()
	local totalStarCount = self._chapterMo:getTotalStarCount()
	local fillAmount = starCount / totalStarCount

	if fillAmount <= 0.3333333333333333 then
		self._line1Img.fillAmount = fillAmount * 3
		self._line2Img.fillAmount = 0
		self._line3Img.fillAmount = 0
	elseif fillAmount <= 0.6666666666666666 then
		self._line1Img.fillAmount = 1
		self._line2Img.fillAmount = (fillAmount - 0.3333333333333333) * 3
		self._line3Img.fillAmount = 0
	else
		self._line1Img.fillAmount = 1
		self._line2Img.fillAmount = 1
		self._line3Img.fillAmount = (fillAmount - 0.6666666666666666) * 3
	end

	local status = self._chapterMo:getChapterStarRewardStatus()

	if status == CommEnum.RewardEnum.CanNotGot then
		goutil.setActive(self._canGetEffectGo, false)
		goutil.setActive(self._normalBoxGo, true)
		goutil.setActive(self._canGetBoxGo, false)

		self._normalBoxImg.color = Astral.ColorUtil.ParseColor("#FFFFFF33")
	elseif status == CommEnum.RewardEnum.CanGot then
		goutil.setActive(self._canGetEffectGo, true)
		goutil.setActive(self._normalBoxGo, false)
		goutil.setActive(self._canGetBoxGo, true)
	else
		goutil.setActive(self._canGetEffectGo, false)
		goutil.setActive(self._normalBoxGo, true)
		goutil.setActive(self._canGetBoxGo, false)

		self._normalBoxImg.color = Astral.ColorUtil.ParseColor("#FFFFFFFF")
	end
end

return M
