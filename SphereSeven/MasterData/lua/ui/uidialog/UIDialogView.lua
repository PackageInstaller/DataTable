local UIDialogView = BaseClass("UIDialogView", UIBaseView);
local base = UIBaseView
local this = UIDialogView

function this.OnCreate(self)
    base.OnCreate(self)

    require "UI.UIDialog.UIDialogMapping"
    require "UI.UIDialog.UIDialogDefine"
    require "UI.UIDialog.UIDialogPreload"
    require "UI.UIDialog.UIDialogScene"
    require "UI.UIDialog.UIDialogCg"
    require "UI.UIDialog.UIDialogDrawing"
    require "UI.UIDialog.UIDialogParticleEffect"
    require "UI.UIDialog.UIDialogBgm"
    require "UI.UIDialog.UIDialogAudio"
    require "UI.UIDialog.UIDialogDialog"

    xpcall(function ()
        -- 获取引用
        self.bgContent = self.rc:GetObject("BgContent")
        self.drawing = self.rc:GetObject("Drawing")
        self.content = self.rc:GetObject("Content")
        self.cg = self.rc:GetObject("Cg")
        self.bgParticle = self.rc:GetObject("BgParticle")
        self.particle = self.rc:GetObject("Particle")
        self.skipBtn = self.rc:GetObject("SkipBtn")
        self.bgmGo = self.rc:GetObject("Bgm")
        self.se = self.rc:GetObject("Se")
        self.left_drawing_img = self.rc:GetObject("LeftDrawing")
        self.middle_drawing_img = self.rc:GetObject("MiddleDrawing")
        self.right_drawing_img = self.rc:GetObject("RightDrawing")
        self.assist_drawing_img = self.rc:GetObject("AssistDrawing")
        self.titleBg = self.rc:GetObject("TitleBg")
        self.bg = self.rc:GetObject("bg")
        self.choose = self.rc:GetObject("Choose")
        self.dialog = self.rc:GetObject("Dialog")
        self.markItem = self.rc:GetObject("MarkItem")
        self.chooseContent = self.rc:GetObject("ChooseContent")
        self.choosePosText = self.rc:GetObject("ChoosePosText")
        self.choosePosMark = self.rc:GetObject("ChoosePosMark")
        self.chooseMarkContent = self.rc:GetObject("ChooseMarkContent")
        self.nameImg = self.rc:GetObject("NameImg")
        self.nameText = self.rc:GetObject("NameText")
        self.dialogText = self.rc:GetObject("DialogText")
        self.dialogTextImg = self.rc:GetObject("DialogTextImg")
        self.dialogPicture = self.rc:GetObject("DialogPicture")
        self.autoBtn = self.rc:GetObject("AutoBtn")
        self.speedOneBtn = self.rc:GetObject("SpeedOneBtn")
        self.speedTwoBtn = self.rc:GetObject("SpeedTwoBtn")
        self.cursor = self.rc:GetObject("Cursor")
        self.dialogBox = self.rc:GetObject("DialogBox")
        self.posText = self.rc:GetObject("PosText")
        self.posMark = self.rc:GetObject("PosMark")
        self.markContent = self.rc:GetObject("MarkContent")
        self.logBtn = self.rc:GetObject("LogBtn")
        self.log = self.rc:GetObject("Log")
        self.scrollbar = self.rc:GetObject("ScrollbarVertical")
        self.logTxt = self.rc:GetObject("LogTxt")
        self.showBtn = self.rc:GetObject("ShowBtn")
        self.graySkipBtn = self.rc:GetObject("GraySkipBtn")
        self.grayLogBtn = self.rc:GetObject("GrayLogBtn")
        self.grayAutoBtn = self.rc:GetObject("GrayAutoBtn")
        self.graySpeedOneBtn = self.rc:GetObject("GraySpeedOneBtn")
        self.graySpeedTwoBtn = self.rc:GetObject("GraySpeedTwoBtn")
        self.grayShowBtn = self.rc:GetObject("GrayShowBtn")

        -- 特效相关
        self.blink = self.rc:GetObject("Blink")
        --self.loadingSlider = self.rc:GetObject("LoadingSlider"):GetComponent("Slider")
        self.logBar = self.scrollbar:GetComponent("Scrollbar")
        
        LangUtil.BindText(self.posText, FontType.All_Dialog)
        LangUtil.BindText(self.posMark, FontType.All_Dialog)

        -- 绑定事件
        EventTriggerListener.Get(self.skipBtn).onLuaClick = function() Game.Scene:GetComponent("DialogComponent"):PlayEnd() end
        EventTriggerListener.Get(self.autoBtn).onLuaClick = function() self:OnAutoBtnClick() end
        EventTriggerListener.Get(self.speedOneBtn).onLuaClick = function() self:OnSpeedOneBtnClick() end
        EventTriggerListener.Get(self.speedTwoBtn).onLuaClick = function() self:OnSpeedTwoBtnClick() end
        EventTriggerListener.Get(self.content).onLuaClick = function() self:OnDialogBoxClick() end
        EventTriggerListener.Get(self.logBtn).onLuaClick = function() self:OnLogBtnClick() end
        EventTriggerListener.Get(self.showBtn).onLuaClick = function() self:OnShowBtnClick() end

        EventTriggerListener.Get(self.graySkipBtn).onLuaClick = function() Game.Scene:GetComponent("DialogComponent"):PlayEnd() end
        EventTriggerListener.Get(self.grayAutoBtn).onLuaClick = function() self:OnAutoBtnClick() end
        EventTriggerListener.Get(self.graySpeedOneBtn).onLuaClick = function() self:OnSpeedOneBtnClick() end
        EventTriggerListener.Get(self.graySpeedTwoBtn).onLuaClick = function() self:OnSpeedTwoBtnClick() end
        EventTriggerListener.Get(self.grayLogBtn).onLuaClick = function() self:OnLogBtnClick() end
        EventTriggerListener.Get(self.grayShowBtn).onLuaClick = function() self:OnGrayShowBtnClick() end
        coroutine.start(function ()
            -- 测试用 --
            if CS.UnityEngine.Application.isEditor then
                self.ipt = self.rc:GetObject("InputField")
                self.btn = self.rc:GetObject("Button")
                self.lastBtn = self.rc:GetObject("LastButton")
                self.toggle = self.rc:GetObject("Toggle")
                self.ipt:SetActive(true)
                self.btn:SetActive(true)
                self.lastBtn:SetActive(true)
                self.toggle:SetActive(true)
                EventTriggerListener.Get(self.btn).onLuaClick = function()
                    local ipt = self.ipt:GetComponent("InputField")
                    if string.IsNullOrEmpty(ipt.text) then return end
                    Game.Scene:GetComponent("DialogComponent"):JumpNextStep(ipt.text)
                end
                EventTriggerListener.Get(self.lastBtn).onLuaClick = function()
                    local ipt = self.ipt:GetComponent("InputField")
                    if string.IsNullOrEmpty(ipt.text) then return end
                    Game.Scene:GetComponent("DialogComponent"):JumpNextStep(ipt.text - 1)
                end
                EventTriggerListener.Get(self.toggle).onLuaClick = function()
                    local toggle = self.toggle:GetComponent("Toggle")
                    Game.Scene:GetComponent("BgmComponent"):SetVolume(toggle.isOn and ClientData:GetInstance():GetVolume("BgmVolume") or 0)
                end
            end
        end)
     end, function ()
        Logger.LogError("UIDialogView OnCreate error!")
    end)
end

function this.OnChangeStep(self, key)
    if self.ipt ~= nil then
        self.ipt:GetComponent("InputField").text = key
    end
end

-- 每帧更新
function this.Update(self)
    xpcall(function()
        self:DialogUpdate()
    end, function (msg) Logger.LogError(msg) end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnPreloadEnable()
    self:OnSceneEnable()
    self:OnCgEnable()
    self:OnDrawingEnable()
    self:OnParticleEffectEnable()
    self:OnBgmEnable()
    self:OnAudioEnable()
    self:OnDialogEnable()
    coroutine.start(function ()
        Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
    end)
end

function this.OnDisable(self)
    base.OnDisable(self)
    self:OnPreloadDisable()
    self:OnSceneDisable()
    self:OnCgDisable()
    self:OnDrawingDisable()
    self:OnParticleEffectDisable()
    self:OnBgmDisable()
    self:OnAudioDisable()
    self:OnDialogDisable()
end

return this