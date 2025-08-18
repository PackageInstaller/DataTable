-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeLosderGrid.lua

local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local NewMazeLosderGrid = Class("NewMazeLosderGrid", UIControls.Child)

function NewMazeLosderGrid:ctor(...)
	self:initUI()
end

function NewMazeLosderGrid:initUI(...)
	self.losderSliderPanel1 = UIControls.Panel(self, "LosderSliderPanel1")
	self.losderSliderPanel2 = UIControls.Panel(self, "LosderSliderPanel2")
	self.iconLosder = UIControls.Image(self, "LosderPanel/IconLosder")
	self.iconHalo = UIControls.Image(self, "LosderPanel/IconHalo")
	self.bgLosder = UIControls.Image(self, "LosderPanel/BgLosder")
	self.imgSel = UIControls.Panel(self, "ImgSel")
	self.efxAct = UIControls.LazyEffectPlayer(self, "LosderPanel/EfxAct")
	self.efxStage = UIControls.LazyEffectPlayer(self, "LosderPanel/EfxStage")
	self.audioPanel = UIControls.LazyAudioPlayer(self, "LosderPanel/EfxAct")
	self.panel2Reach = UIControls.Panel(self, "LosderSliderPanel2/BgSlider1/ImgReach")
	self.panel2Own = UIControls.Panel(self, "LosderSliderPanel2/BgSlider1/ImgOwn")
	self.panelReachList = {}

	for i = 1, 4 do
		local panelReach = UIControls.Panel(self, "LosderSliderPanel1/BgSlider" .. i .. "/ImgReach")
		local panelOwn = UIControls.Panel(self, "LosderSliderPanel1/BgSlider" .. i .. "/ImgOwn")
		local aniSlider = UIControls.UIAni(self, "LosderSliderPanel1/BgSlider" .. i)

		table.insert(self.panelReachList, {
			panelReach = panelReach,
			panelOwn = panelOwn,
			aniSlider = aniSlider
		})
	end

	self.gridLosder = UIControls.Button(self, "")

	self.gridLosder:addEventClick(self.onGridLosderClick)
end

function NewMazeLosderGrid:setData(fettersData)
	self.fettersData = fettersData
	self.fettersType = self.fettersData.type
	self.formationNum = #self.fettersData.formationHeros

	for i, data in pairs(ResNewMazeFetters) do
		if self.fettersType < Const.SPECIAL_FETTERS_TYPE then
			if self.fettersData.num + #self.fettersData.halo + #self.fettersData.notUseHalo >= Const.FETTERS_ACTIVE_LEVEL2_NUM then
				if data.type == self.fettersType and data.level == 2 then
					self.fettersTableData = data

					break
				end
			elseif data.type == self.fettersType and data.level == 1 then
				self.fettersTableData = data

				break
			end
		elseif self.fettersData.formationNum >= Const.CAREER_MAX_NUM and self.formationNum == 6 then
			if data.career and data.type == self.fettersType and data.level == 2 then
				local fettertCareer = 1
				local careerList = {}

				for i, career in pairs(self.fettersData.formationHeros) do
					if not utils.tableIsContainsElement(careerList, career) then
						table.insert(careerList, career)
					else
						fettertCareer = career

						break
					end
				end

				if fettertCareer == data.career then
					self.fettersTableData = data

					break
				end
			end
		elseif data.type == self.fettersType and data.level == 1 then
			self.fettersTableData = data

			break
		end
	end

	self.losderSliderPanel1:setVisible(self.fettersType < Const.SPECIAL_FETTERS_TYPE)
	self.losderSliderPanel2:setVisible(self.fettersType >= Const.SPECIAL_FETTERS_TYPE)
	self.iconHalo:setVisible(#self.fettersData.halo > 0)
	self.efxAct:setVisible(false)
	self.efxStage:setVisible(false)

	if self.fettersType < Const.SPECIAL_FETTERS_TYPE then
		for i = 1, 4 do
			self.panelReachList[i].panelReach:setVisible(i <= self.formationNum + #self.fettersData.halo)
			self.panelReachList[i].panelOwn:setVisible(i > self.formationNum + #self.fettersData.halo and i <= self.fettersData.num + #self.fettersData.halo + #self.fettersData.notUseHalo)
			self.panelReachList[i].aniSlider:stopAni("LoopLosderSlider1")
			self.panelReachList[i].panelReach:setCanvasGroupAlpha(1)
			self.panelReachList[i].panelOwn:setCanvasGroupAlpha(1)
		end

		if self.fettersData.needFormationAni then
			local num = self.formationNum + #self.fettersData.halo

			if num <= 4 then
				self.panelReachList[num].panelReach:setVisible(true)
				self.panelReachList[num].aniSlider:startAniLoop("LoopLosderSlider1")
			end
		elseif self.fettersData.needNormalAni then
			local num = self.fettersData.num + #self.fettersData.halo + #self.fettersData.notUseHalo

			if num <= 4 then
				self.panelReachList[num].panelOwn:setVisible(true)
				self.panelReachList[num].aniSlider:startAniLoop("LoopLosderSlider1")
			end
		end

		if self.formationNum + #self.fettersData.halo >= Const.FETTERS_ACTIVE_NUM then
			self.iconLosder:setImage(self.fettersTableData.icon_path, self.fettersTableData.icon_name)
			self.bgLosder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder", "BgFetter2")
			self.efxStage:setVisible(self.formationNum + #self.fettersData.halo >= Const.FETTERS_ACTIVE_LEVEL2_NUM)
		else
			self.iconLosder:setImage(self.fettersTableData.icon_path, self.fettersTableData.icon_inactiva_name)
			self.bgLosder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder", "BgFetter1")
			self.efxStage:setVisible(false)
		end
	else
		self.panel2Reach:setVisible(self.fettersData.formationNum >= Const.CAREER_MAX_NUM)
		self.panel2Own:setVisible(self.fettersData.formationNum < Const.CAREER_MAX_NUM)

		if self.fettersData.formationNum < Const.CAREER_MAX_NUM and self.fettersTableData.icon_inactiva_name then
			self.iconLosder:setImage(self.fettersTableData.icon_path, self.fettersTableData.icon_inactiva_name)
			self.bgLosder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder", "BgFetter1")
			self.efxStage:setVisible(false)
		else
			self.iconLosder:setImage(self.fettersTableData.icon_path, self.fettersTableData.icon_name)
			self.bgLosder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder", "BgFetter2")
			self.efxStage:setVisible(self.fettersData.formationNum > Const.CAREER_MAX_NUM)
		end
	end
end

function NewMazeLosderGrid:playEfx()
	if self.fettersType < Const.SPECIAL_FETTERS_TYPE then
		if self.formationNum + #self.fettersData.halo == Const.FETTERS_ACTIVE_LEVEL2_NUM then
			self.audioPanel:setAudioPath("Audios/SFX/UI/ui_roguesolder02.ogg")
			self.audioPanel:playAudio()
		elseif self.formationNum + #self.fettersData.halo == Const.FETTERS_ACTIVE_NUM then
			self.efxAct:setVisible(false)
			self.efxAct:setVisible(true)
			self.audioPanel:setAudioPath("Audios/SFX/UI/ui_roguesolder01.ogg")
			self.audioPanel:playAudio()
		else
			self.efxAct:setVisible(false)
		end
	elseif self.fettersData.formationNum < Const.CAREER_MAX_NUM then
		self.efxAct:setVisible(false)
	elseif self.fettersData.formationNum == Const.CAREER_MAX_NUM then
		self.efxAct:setVisible(false)
		self.efxAct:setVisible(true)
		self.audioPanel:setAudioPath("Audios/SFX/UI/ui_roguesolder01.ogg")
		self.audioPanel:playAudio()
	else
		self.audioPanel:setAudioPath("Audios/SFX/UI/ui_roguesolder02.ogg")
		self.audioPanel:playAudio()
	end
end

function NewMazeLosderGrid:setGridClick(onGridClick)
	self.onGridClick = onGridClick
end

function NewMazeLosderGrid:onGridLosderClick()
	if self.onGridClick then
		self.onGridClick(self)
	end
end

return NewMazeLosderGrid
