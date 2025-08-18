-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\StepUpDonePanel.lua

local strClassName = "StepUpDonePanel"
local StepUpDonePanel = Class(strClassName, UIControls.Child)

function StepUpDonePanel:ctor()
	self:initUI()
end

function StepUpDonePanel:initUI()
	self.txtUpDoneDes = UIControls.Label(self, "Text")
	self.imgUpDoneBg = UIControls.Image(self, "Bg")
	self.imgIconSkill = UIControls.Image(self, "Bg/Icon")
	self.txtUnlockSkill = UIControls.Label(self, "Bg/Icon/Text")
	self.imgLockSkill = UIControls.Image(self, "Bg/Icon/ImgLock")
	self.imgFront = UIControls.Image(self, "Bg/Icon/ImgFront")
	self.txtTime = UIControls.Label(self, "Bg/TextTime")
	self.txtAllDes = UIControls.Label(self, "Bg/TextDes2")
	self.panelCharacterText = UIControls.Panel(self, "Bg/TextCharacterPanel")
	self.txtCharacterList = {}

	for i = 1, 6 do
		local txtChar = UIControls.Label(self, "Bg/TextCharacterPanel/Text" .. i)

		table.insert(self.txtCharacterList, txtChar)
	end
end

function StepUpDonePanel:setData(data)
	self.stepDesInfo = data

	self.imgIconSkill:setVisible(false)
	self.txtUnlockSkill:setVisible(false)
	self.imgLockSkill:setVisible(false)
	self.imgFront:setVisible(false)
	self.txtTime:setVisible(false)
	self.txtAllDes:setVisible(false)
	self.panelCharacterText:setVisible(false)
	self.txtUpDoneDes:setText(self.stepDesInfo.step_desc)

	if self.stepDesInfo.atlas_path then
		self.imgUpDoneBg:setImage("Atlas/" .. self.stepDesInfo.atlas_path, self.stepDesInfo.sprite_name)
	end

	if self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.SKILL then
		self.txtUnlockSkill:setVisible(true)
		self.imgLockSkill:setVisible(true)
		self.imgFront:setVisible(true)
	elseif self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.TIMETEXT then
		self.imgFront:setVisible(true)
		self.txtTime:setVisible(true)
		self.txtTime:setText(self.stepDesInfo.all_desc)
	elseif self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.DESTEXT then
		self.txtAllDes:setVisible(true)
		self.txtAllDes:setText(self.stepDesInfo.all_desc)
	elseif self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.CHARACTERTEXT then
		self.panelCharacterText:setVisible(true)

		for i, str in ipairs(self.stepDesInfo.char_text) do
			self.txtCharacterList[i]:setText(str)
		end
	elseif self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.IMAGE then
		-- block empty
	end

	if self.stepDesInfo.show_type == UIConst.HERO_STEPUP_DES_SHOW_TPYE.SKILL then
		self.imgIconSkill:setVisible(true)

		local iconPath = self.mParent.skillPanel.skill:getIconPath()

		if iconPath then
			self.imgIconSkill:setImage(iconPath[1], iconPath[2])
		end
	else
		self.imgIconSkill:setVisible(false)
	end
end

return StepUpDonePanel
