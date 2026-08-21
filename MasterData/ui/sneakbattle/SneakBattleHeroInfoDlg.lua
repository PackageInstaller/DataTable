-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleHeroInfoDlg.lua

local RoleInfoHeroDlg = require("UI/RoleInfo/RoleInfoHeroDlg")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local SneakBattleHeroInfoDlg = Class("SneakBattleHeroInfoDlg", RoleInfoHeroDlg)

function SneakBattleHeroInfoDlg:ctor(...)
	self:_initUI()
end

function SneakBattleHeroInfoDlg:_initUI(...)
	self.panelDes = UIControls.Panel(self, "HeroContentPanel/ImgDes")
	self.txtDes = UIControls.Label(self, "HeroContentPanel/ImgDes/TxtDes")

	if ResNewPveShow[13090005] then
		self.txtDes:setText(ResNewPveShow[13090005].desc)
		self.panelDes:setVisible(true)
	end
end

function SneakBattleHeroInfoDlg:setData(actData, heros, idx)
	self.heros = heros
	self.idx = idx or 1
	self.actData = actData or self.actData

	self:setSelectHero(self.idx)
	self:setVisible(true)
end

function SneakBattleHeroInfoDlg:setSelectHero(idx)
	SneakBattleHeroInfoDlg.super.setSelectHero(self, idx)

	self.idx = idx

	if self.actData then
		self.dataList = self.actData:getCanWearRelicsInSeakBattle(self.selectedHero)

		if self.dataList and #self.dataList > 0 and (not self.actData.heroRelicDic[self.selectedHero.id] or self.actData.heroRelicDic[self.selectedHero.id] == 0) then
			self.imgRelicNew:setVisible(true)
		else
			self.imgRelicNew:setVisible(false)
		end
	end
end

function SneakBattleHeroInfoDlg:refreshUISneakBattle(heros)
	self:setData(nil, heros, self.idx)
end

function SneakBattleHeroInfoDlg:onRelicGridClick(sender)
	if self.actData then
		if self.dataList and #self.dataList > 0 then
			local relicWearDlg = UIManager.getUI("relicWearDlg", true)

			relicWearDlg:setHero(self.selectedHero, self.dataList, nil, nil, nil, nil, true)
			relicWearDlg.panelFund:setVisible(false)
		else
			MsgManager.clientNotice(281)
		end
	end
end

return SneakBattleHeroInfoDlg
