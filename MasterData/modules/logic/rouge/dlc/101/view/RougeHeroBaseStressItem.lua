-- chunkname: @modules/logic/rouge/dlc/101/view/RougeHeroBaseStressItem.lua

module("modules.logic.rouge.dlc.101.view.RougeHeroBaseStressItem", package.seeall)

local RougeHeroBaseStressItem = class("RougeHeroBaseStressItem", LuaCompBase)

RougeHeroBaseStressItem.AssetUrl = RougeDLCEnum101.StressPrefabPath

function RougeHeroBaseStressItem:init(go)
	RougeHeroBaseStressItem.super.init(self, go)

	self.gostress = go
	self.blueText = gohelper.findChildText(go, "#txt_stress")
	self.goBlue = gohelper.findChild(go, "blue")
	self.goRed = gohelper.findChild(go, "red")

	local goBroken = gohelper.findChild(go, "broken")
	local goStaunch = gohelper.findChild(go, "staunch")

	gohelper.setActive(goBroken, false)
	gohelper.setActive(goStaunch, false)

	self.status2GoDict = self:getUserDataTb_()
	self.status2GoDict[FightEnum.Status.Positive] = self.goBlue
	self.status2GoDict[FightEnum.Status.Negative] = self.goRed
end

function RougeHeroBaseStressItem:onUpdateDLC(mo)
	self:refreshUI(mo)
end

function RougeHeroBaseStressItem:refreshUI(mo)
	local curStress = self:getCurStress(mo)

	gohelper.setActive(self.gostress, mo ~= nil and curStress ~= nil)

	if not curStress then
		return
	end

	self.blueText.text = curStress
	self.status = FightHelper.getStressStatus(curStress)

	for status, go in pairs(self.status2GoDict) do
		gohelper.setActive(go, status == self.status)
	end
end

function RougeHeroBaseStressItem:getCurStress(heroMo)
	local teamInfo = RougeModel.instance:getTeamInfo()
	local heroInfo = teamInfo:getHeroInfo(heroMo and heroMo.heroId)

	if not heroInfo then
		return
	end

	return (heroInfo:getStressValue())
end

return RougeHeroBaseStressItem
