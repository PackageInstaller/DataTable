-- chunkname: @modules/logic/story/define/StoryEnum.lua

module("modules.logic.story.define.StoryEnum", package.seeall)

local StoryEnum = _M

StoryEnum.StepType = {
	Interaction = 1,
	Normal = 0
}
StoryEnum.ConversationType = {
	ScreenDialog = 5,
	Normal = 1,
	NoInteract = 6,
	IrregularShake = 8,
	BgEffStack = 10,
	NoRole = 3,
	Aside = 2,
	SlideDialog = 7,
	LimitNoInteract = 9,
	Player = 4,
	None = 0
}
StoryEnum.ConversationEffectType = {
	GoldlineMagic = 15,
	ReshapeMagic = 9,
	GostMagic = 12,
	SandMagic = 14,
	SoftLight = 8,
	Hard = 6,
	LineByLine = 4,
	WordByWord = 3,
	XranMagic = 16,
	TwoLineShow = 5,
	Glitch = 10,
	SilverMagic = 11,
	Shake = 1,
	Fade = 2,
	SoftLightDarkBg = 13,
	CommonMagic = 7,
	None = 0
}
StoryEnum.HeroPos = {
	Right = 2,
	Middle = 1,
	Left = 0
}
StoryEnum.HeroEffect = {
	SetFlash = "setFlash",
	StyDissolve = "stydissolve",
	Glow = "glow",
	Gray = "gray",
	BlackFog = "blackFog",
	SetSkin = "setSkin",
	WaterWave = "waterWave",
	SetDissolve = "setDissolve",
	DissolveAndSoft = "dissolveAndSoft",
	Erase = "erase",
	HideNode = "hideNode",
	SetAlpha = "setAlpha",
	ShowNode = "showNode",
	KeepAction = "keepAction",
	SetParam = "setParam"
}
StoryEnum.BgType = {
	Video = 2,
	Picture = 0,
	Effect = 1
}
StoryEnum.BgTransType = {
	WhiteFade = 4,
	KaleidoscopeIn = 23,
	ShakeCameraLR = 30,
	HotPixel2 = 22,
	MeltOut15 = 26,
	LeftDarkFade = 16,
	Distort = 10,
	UpDarkFade = 5,
	MeltIn25 = 29,
	TurnPage1 = 11,
	Burn = 13,
	Dissolve = 8,
	Keep = 0,
	HotPixel1 = 21,
	Filter = 9,
	XiQuKeKe2 = 18,
	SceneLightIn = 33,
	ChangeScene1 = 14,
	RightDarkFade = 6,
	MovieChangeStart = 19,
	DarkFade = 3,
	MeltIn15 = 27,
	MovieChangeSwitch = 20,
	Bloom2 = 32,
	SceneDarkInstant = 37,
	ChangeScene2 = 15,
	MountainDestroy = 44,
	Fragmentate = 7,
	SceneDarkOut = 36,
	TurnPage3 = 25,
	TextureShake = 42,
	Hard = 1,
	MountainExplosion = 43,
	ScreenSplit = 40,
	TurnPageTop = 45,
	TurnPage2 = 12,
	XiQuKeKe1 = 17,
	RiverBg = 38,
	MeltOut25 = 28,
	SceneLightOut = 34,
	ShakeCameraUD = 39,
	ScreenSplitExit = 41,
	KaleidoscopeOut = 24,
	SceneDarkIn = 35,
	TransparencyFade = 2,
	Bloom1 = 31
}
StoryEnum.BgEffectType = {
	BgBlur = 1,
	TextureShake = 27,
	LineLight = 24,
	FishEye = 2,
	CustomBlur = 23,
	Starburst = 18,
	EagleEye = 13,
	FullBlur = 4,
	Malfunction = 29,
	Filter = 14,
	TimeStop = 32,
	CameraEffect = 37,
	CrtFilter = 36,
	BgDistress = 20,
	ScreenHalo2 = 35,
	BlindFilter = 10,
	Penetration = 22,
	RgbSplit = 12,
	None = 0,
	BgGray = 5,
	EnterSplitScreen = 25,
	FullGray = 6,
	SetLayer = 19,
	Opposition = 11,
	ScreenHalo = 34,
	PerspectiveCamera = 31,
	DiamondLight = 17,
	MoveCurve = 7,
	OutFocus = 16,
	ShapeMask = 28,
	PartialBlur = 30,
	UpFlow = 33,
	Distress = 15,
	HandCameraShake = 21,
	ExitSplitScreen = 26,
	BgShake = 3,
	Interfere = 8,
	Sketch = 9
}
StoryEnum.BgRgbSplitType = {
	Once = 1,
	LoopStrong = 3,
	LoopWeak = 2,
	Trans = 0
}
StoryEnum.AudioOrderType = {
	Destroy = 2,
	Single = 1,
	SetSwitch = 4,
	Adjust = 3,
	Continuity = 0
}
StoryEnum.AudioInType = {
	FadeIn = 1,
	Hard = 0
}
StoryEnum.AudioOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.EffectOrderType = {
	Continuity = 0,
	Single = 1,
	ContinuityUnscale = 3,
	SingleUnscale = 4,
	NoSettingFollowBg = 8,
	FollowBg = 7,
	Destroy = 2,
	NoSetting = 5,
	FollowDialog = 9,
	NoSettingUnScale = 6
}
StoryEnum.EffectInType = {
	FadeIn = 1,
	Hard = 0
}
StoryEnum.EffectOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.EffDegree = {
	High = 3,
	Middle = 2,
	Low = 1,
	None = 0
}
StoryEnum.PictureType = {
	HeroFollow = 5,
	Transparency = 4,
	PicTxt = 3,
	Float = 2,
	FullScreen = 1,
	Normal = 0
}
StoryEnum.PictureOrderType = {
	Destroy = 1,
	Produce = 0
}
StoryEnum.PictureInType = {
	SoftLight = 3,
	GostMagic = 4,
	FadeIn = 1,
	TxtFadeIn = 2,
	Hard = 0
}
StoryEnum.PictureOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.PictureEffectType = {
	Scale = 3,
	FollowBg = 2,
	Shake = 1,
	None = 0
}
StoryEnum.VideoOrderType = {
	Destroy = 1,
	Produce = 0,
	ProduceSkip = 4,
	Restart = 3,
	Pause = 2
}
StoryEnum.OptionFeedbackType = {
	HeroLead = 1,
	None = 0
}
StoryEnum.OptionConditionType = {
	MainSpine = 2,
	NormalLead = 1,
	None = 0
}
StoryEnum.OptionType = {
	Normal = 1,
	SpClick = 2,
	EndAsk = 6,
	ContinueAsk = 5,
	SpLongClick = 4,
	SpSlide = 3,
	None = 0
}
StoryEnum.NavigateType = {
	StormTimerStart = 13,
	ActivityStart = 6,
	ChapterStart = 3,
	HideBtns = 5,
	Map = 1,
	FullScreenCountdown = 12,
	StormDeadline = 9,
	RoleStoryStart = 8,
	StrategyStart = 10,
	ChapterEnd = 4,
	FullScreenCountdownEnd = 15,
	ScoreCard = 16,
	Episode = 2,
	StormTimerEnd = 14,
	StrategyEnd = 11,
	ActivityEnd = 7,
	None = 0
}
StoryEnum.StrategyBtnType = {
	CmdPost = 1
}
StoryEnum.SkipType = {
	ChapterEnd = 4,
	InDarkFade = 1,
	OutDarkFade = 2,
	AudioFade = 3,
	None = 0
}
StoryEnum.BorderType = {
	FadeOut = 1,
	Keep = 3,
	FadeIn = 2,
	None = 0
}
StoryEnum.IconResType = {
	IconEff = 1,
	Spine = 0
}
StoryEnum.PicLayer = {
	UpCon1 = 7,
	BetweenHeroAndCon1 = 4,
	BetweenBgAndHero3 = 3,
	UpCon3 = 9,
	Top = 10,
	BetweenHeroAndCon2 = 5,
	UpCon2 = 8,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6
}
StoryEnum.EffLayer = {
	UpCon1 = 7,
	BetweenHeroAndCon1 = 4,
	BetweenBgAndHero3 = 3,
	UpCon3 = 9,
	Top = 10,
	BetweenHeroAndCon2 = 5,
	UpCon2 = 8,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6
}
StoryEnum.VideoLayer = {
	BetweenBgAndHero3 = 3,
	BetweenHeroAndCon1 = 4,
	UpCon1 = 7,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6,
	BetweenHeroAndCon2 = 5
}
StoryEnum.FullScreenCountdownBgType = {
	Emergency = 2,
	Normal = 1
}
StoryEnum.FullScreenCountdownAnimType = {
	Down = 2,
	Up = 1,
	Direct = 3
}
StoryEnum.MaterialPropType = {
	Texture = 3,
	Float = 0,
	Vector = 2,
	Color = 1
}
StoryEnum.ScoreCardAnimType = {
	dafenban2_end = 6,
	dafenban8_start = 3,
	dafenban4_end = 7,
	dafenban3 = 1,
	dafenban1_start = 0,
	dafenban1_end = 5,
	dafenban5_end = 8,
	dafenban8_end = 9,
	dafenban5_change = 4,
	dafenban4_start = 2
}

return StoryEnum
