-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\GetNewSkinDlg.lua

local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItem = require("ClientData/ResItem")
local ResHero = require("ClientData/ResHero")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ResSeasonSkinShow = require("ClientData/ResSeasonSkinShow")
local strClassName = "GetNewSkinDlg"
local GetNewSkinDlg = Class(strClassName, UIControls.Window)

function GetNewSkinDlg:ctor()
	self:initUI()
end

function GetNewSkinDlg:initUI()
	self.roleSkin = UIControls.Role(self, "InfoPanel/SkinDraw", 0, 0)
	self.txtName = UIControls.Label(self, "InfoPanel/TxtName")
	self.txtRule = UIControls.Panel(self, "RulePanel")
	self.btnBlock = UIControls.Button(self, "Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.imgSeasonPlay = UIControls.Image(self, "ImgSeasonPlay")
	self.sharePanel = ShareAchievePanel(self, "SharePanel")
end

function GetNewSkinDlg:setSkin(data)
	local heroId = data[1]
	local skinId = data[2]

	if heroId and skinId then
		local skinData = ResItemHeroSkin[heroId][skinId]

		if not skinData then
			self:setVisible(false)

			return
		else
			self:refreshUI(skinData)

			if skinData.vocal_id then
				CueManager.playVocal(skinData.vocal_id)
			end
		end
	end
end

function GetNewSkinDlg:refreshUI(skinData)
	local heroData = ResHero[skinData.hero_id]
	local name = skinData.name

	if heroData and heroData.hero_name then
		name = heroData.hero_name .. "·" .. name
	end

	local geted = CurAvatar.handBookHeroDic[skinData.hero_id] ~= nil

	self.txtRule:setVisible(not geted)
	self.roleSkin:showRole(skinData.port_id, UIConst.ROLEIMAGE_SHOWTYPE_GET_SKIN)
	self.txtName:setText(name)

	local itemId = skinData.itemId

	if itemId and ResSeasonSkinShow and ResSeasonSkinShow[itemId] and ResSeasonSkinShow[itemId].season_logo_path then
		self.imgSeasonPlay:setVisible(true)
		self.imgSeasonPlay:setImage(ResSeasonSkinShow[itemId].season_logo_path, ResSeasonSkinShow[itemId].season_logo_name)
	else
		self.imgSeasonPlay:setVisible(false)
	end

	self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_NEWSKIN, self.mUIName)
	self.sharePanel:setShareVisible(true)
end

function GetNewSkinDlg.getGroupLargePath(camp)
	if camp == Const.CAMP_TYPE.SLIM_SNOW or camp == Const.CAMP_TYPE.NINE_NIGHT then
		return {
			"Atlas/OtherBattleAtlas/EquipTowerAtlas2",
			"IconGroupL0" .. camp
		}
	else
		return {
			"Atlas/OtherBattleAtlas/EquipTowerAtlas",
			"IconGroupL0" .. camp
		}
	end
end

function GetNewSkinDlg.getGragCareerPath(career)
	return {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"IconCareerW0" .. career
	}
end

function GetNewSkinDlg:addOneSkin(heroId, skinId)
	if self.skinList then
		table.insert(self.skinList, {
			heroId,
			skinId
		})
	else
		self.skinList = {}

		self:setSkin({
			heroId,
			skinId
		})
	end
end

function GetNewSkinDlg:onBtnBlockClick()
	CueManager.stopVocal()

	if self.skinList and #self.skinList > 0 then
		self:setSkin(self.skinList[1])
		table.remove(self.skinList, 1)
	else
		self:setVisible(false)
	end
end

return GetNewSkinDlg
