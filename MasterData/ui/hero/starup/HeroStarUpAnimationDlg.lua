-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpAnimationDlg.lua

local strClassName = "HeroStarUpAnimationDlg"
local ANI_EFX_PATH_INFO = {
	[4] = {
		"dongxiao_02",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_02.prefab",
		"Audios/SFX/UI/ui_starup_1.ogg"
	},
	[5] = {
		"dongxiao_02",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_03.prefab",
		"Audios/SFX/UI/ui_starup_1.ogg"
	},
	[6] = {
		"dongxiao_02",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_04.prefab",
		"Audios/SFX/UI/ui_starup_1.ogg"
	},
	[7] = {
		"dongxiao_03_2xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_04.prefab",
		"Audios/SFX/UI/ui_starup_2.ogg"
	},
	[8] = {
		"dongxiao_04_3xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_04.prefab",
		"Audios/SFX/UI/ui_starup_3.ogg"
	},
	[9] = {
		"dongxiao_05_4xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_04.prefab",
		"Audios/SFX/UI/ui_starup_4.ogg"
	},
	[10] = {
		"dongxiao_06_5xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_04.prefab",
		"Audios/SFX/UI/ui_starup_5.ogg"
	},
	[11] = {
		"dongxiao_02",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_05.prefab",
		"Audios/SFX/UI/ui_starup_6.ogg"
	},
	[12] = {
		"dongxiao_03_2xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_05.prefab",
		"Audios/SFX/UI/ui_starup_2.ogg"
	},
	[13] = {
		"dongxiao_04_3xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_05.prefab",
		"Audios/SFX/UI/ui_starup_3.ogg"
	},
	[14] = {
		"dongxiao_05_4xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_05.prefab",
		"Audios/SFX/UI/ui_starup_4.ogg"
	},
	[15] = {
		"dongxiao_06_5xing",
		"Effects/UI/HeroStarUpAnimationCanvas_Effect_05.prefab",
		"Audios/SFX/UI/ui_starup_5.ogg"
	}
}
local HeroStarUpAnimationDlg = Class(strClassName, UIControls.Window)

function HeroStarUpAnimationDlg:ctor()
	self:initUI()
end

function HeroStarUpAnimationDlg:initUI()
	self.imgTriangleColor = UIControls.Image(self, "Bg/ImgTriangle1/ImgTriangle")
	self.imgTriangleList = {}

	for i = 2, 6 do
		local image = UIControls.Image(self, "Bg/ImgTriangle" .. i)

		table.insert(self.imgTriangleList, image)
	end

	self.imgHero = UIControls.Image(self, "Bg/ImgHero/GridHeroPortrait")
	self.imgStarList = {}

	for i = 1, 5 do
		local image = UIControls.Image(self, "Bg/ImgStarPanel/ImgStar" .. i)

		table.insert(self.imgStarList, image)
	end

	self.imgLineL = UIControls.Image(self, "Bg/ImgStarPanel/ImgLineL")
	self.imgLineR = UIControls.Image(self, "Bg/ImgStarPanel/ImgLineR")
	self.imgOriStarList = {}

	for i = 1, 5 do
		local image = UIControls.Image(self, "Bg/ImgStarPanel_02/ImgStar" .. i)

		table.insert(self.imgOriStarList, image)
	end

	self.imgOriLineL = UIControls.Image(self, "Bg/ImgStarPanel_02/ImgLineL")
	self.imgOriLineR = UIControls.Image(self, "Bg/ImgStarPanel_02/ImgLineR")
	self.imgTextStarUp = UIControls.Image(self, "Bg/ImgStarUp")
	self.imgTextStar = UIControls.Image(self, "Bg/ImgStar")
	self.txtStarUp = UIControls.Label(self, "Bg/Text")
	self.lazyEfx = UIControls.LazyEffectPlayer(self, "EfxPanel")
	self.uiAni = UIControls.UIAni(self, "")
	self.audioPanel = UIControls.LazyAudioPlayer(self, "AudioPanel")
	self.btnClose = UIControls.Button(self, "BtnOver")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function HeroStarUpAnimationDlg:onBtnCloseClick()
	if self.openFinish then
		local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", nil, false)

		if heroStarUpDlg then
			local heroStarUpFinishDlg = UIManager.getUI("heroStarUpFinishDlg", true)

			if heroStarUpFinishDlg then
				heroStarUpFinishDlg:setHero(self.hero)
			end
		end
	end

	self:setVisible(false)
end

function HeroStarUpAnimationDlg:setHero(hero, openFinish)
	self.hero = hero
	self.openFinish = openFinish

	local roleImageData = UIConst.getRoleImageByType(self.hero:getShowPortId(), UIConst.ROLEIMAGE_SHOWTYPE_STAR_UP)

	if roleImageData then
		self.imgHero:setSize(roleImageData[5][1], roleImageData[5][2])
		self.imgHero:setImage(roleImageData[1], roleImageData[2])
		self.imgHero:setPosition(roleImageData[3][1], roleImageData[3][2])
		self.imgHero:setScale(roleImageData[4])
	end

	local stepIdx = self.hero:getStepIdx()

	self.oriHero = BaseObject.CopyObject(self.hero)
	self.oriHero.star = self.hero.star - 1

	local stepOriIdx = self.oriHero:getStepIdx()
	local stepImgInfo = self.hero:getStepBgPath()
	local stepOriImgInfo = self.oriHero:getStepBgPath()
	local color = self:getTriangleColorRgba(stepIdx)

	self.imgTriangleColor:setColorByRGBA(color[1], color[2], color[3], color[4])

	if stepImgInfo then
		for _, image in ipairs(self.imgTriangleList) do
			image:setImage(stepImgInfo.IMG_TRIANGLE[1], stepImgInfo.IMG_TRIANGLE[2])
		end

		for _, image in ipairs(self.imgStarList) do
			image:setImage(stepImgInfo.IMG_STAR[1], stepImgInfo.IMG_STAR[2])
		end

		self.imgLineL:setImage(stepImgInfo.IMG_STAR_L[1], stepImgInfo.IMG_STAR_L[2])
		self.imgLineR:setImage(stepImgInfo.IMG_STAR_R[1], stepImgInfo.IMG_STAR_R[2])
		self.imgTextStar:setImage(stepImgInfo.TEXT_STAR[1], stepImgInfo.TEXT_STAR[2])
	end

	if stepOriImgInfo then
		for _, image in ipairs(self.imgOriStarList) do
			image:setImage(stepOriImgInfo.IMG_STAR[1], stepOriImgInfo.IMG_STAR[2])

			if self.hero.star == 11 then
				image:setVisible(true)
			end
		end

		self.imgOriLineL:setImage(stepOriImgInfo.IMG_STAR_L[1], stepOriImgInfo.IMG_STAR_L[2])
		self.imgOriLineR:setImage(stepOriImgInfo.IMG_STAR_R[1], stepOriImgInfo.IMG_STAR_R[2])
	end

	local color = self.hero:getQualityColor(stepIdx)

	self.imgTextStarUp:setObjColor(color)
	self.txtStarUp:setFontColor(color)

	local starPathInfo = ANI_EFX_PATH_INFO[self.hero.star]

	self.playVocalTimer = Timer.New(Slot(self.playHeroVocal, self), 2.15, 1)

	self.playVocalTimer:Start()
	self.audioPanel:setAudioPath(starPathInfo[3])
	self.lazyEfx:playEffectByPath(starPathInfo[2])
	self.uiAni:addEventFinish(Slot(self.onAniEnd, self))
	self.uiAni:startAni(starPathInfo[1], true)
end

function HeroStarUpAnimationDlg:onClose()
	HeroStarUpAnimationDlg.super.onClose(self)

	if self.playVocalTimer then
		self.playVocalTimer:Stop()

		self.playVocalTimer = nil
	end
end

function HeroStarUpAnimationDlg:playHeroVocal()
	CueManager.playHeroVocal(self.hero.id, Const.HERO_VOCAL_STARUP)
end

function HeroStarUpAnimationDlg:onAniEnd()
	self.btnClose:setVisible(true)
end

function HeroStarUpAnimationDlg:getTriangleColorRgba(stepIdx)
	local color = {}

	if stepIdx == 4 then
		color = {
			78,
			18,
			87,
			193
		}
	elseif stepIdx == 5 then
		color = {
			121,
			95,
			2,
			193
		}
	elseif stepIdx == 6 then
		color = {
			89,
			15,
			33,
			196
		}
	elseif stepIdx == 7 then
		color = {
			111,
			45,
			6,
			196
		}
	end

	return color
end

return HeroStarUpAnimationDlg
