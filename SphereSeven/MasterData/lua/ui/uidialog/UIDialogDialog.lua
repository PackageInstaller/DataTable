local this = require "UI.UIDialog.UIDialogView"

-- 鼠标点击
local sliderMinDis = 20
local clickMaxTime = 1
local clickTime = 0
local startPos = Vector3.New(0, 0, 0)
-- 鼠标向下滑动
local startY = 0
local isClicked = false
-- 持续点击
local clicked = false
local clickedTime = 0
local frame = 0

function this.OnDialogEnable(self)
    -- 持续点击
    clicked = false
    clickedTime = 0
    frame = 0
    -- 鼠标点击
    sliderMinDis = 20
    clickMaxTime = 1
    clickTime = 0
    startPos = Vector3.New(0, 0, 0)
    -- 鼠标向下滑动
    startY = 0
    isClicked = false
    
    -- 对话相关
    self.dialogScript = ""
    self.dialogTxtComponent = nil
    self.dialogTxt = nil
    self.dialogIndex = 0
    self.wordLength = 3
    self.rowLimit = 29
    self.dialogTime = 0
    self.wordDelay = 0.05
    self.endDelay = 4
    self.playEnd = true
    self.dialogEnd = false
    self.speaker = ""

    self.dialogUnits = {}
    self.dialogUnitIndex = 0

    -- 日志
    self.isLog = false

    -- 各种模式
    self.contentType = ContentType.Title
    self.speedMode = SpeedMode.Default
    self.showMode = DialogShowMode.Show
    --self.lastShowMode = DialogShowMode.Show

    self.choosePosTexts = {}
    self.chooseWordHeight = nil

    self.datas = nil
    self.posTexts = {}
    self.wordHeight = nil
    
    self.logBarValue = 0
end

function this.OnDialogDisable(self)
    ListChildPool:GetInstance():ClearContent(self.markContent)
    self.choose:SetActive(false)
    self.dialog:SetActive(false)
    self.titleBg:SetActive(true)
end

-- 隐藏内容
function this.HideContent(self)
    self.content:SetActive(false)
    self.skipBtn:SetActive(false)
    self.graySkipBtn:SetActive(false)
end

-- 切换显示内容
function this.SwitchContent(self, contentType)
    self.content:SetActive(true)
    self.choose:SetActive(false)
    self.dialog:SetActive(false)
    self.titleBg:SetActive(false)

    self.skipBtn:SetActive(false)
    self.graySkipBtn:SetActive(false)
    if contentType == ContentType.Title then
        self.titleBg:SetActive(true)
    elseif contentType == ContentType.Choose then
        self.choose:SetActive(true)
        if self.showMode == DialogShowMode.Show then
            self.skipBtn:SetActive(true)
        elseif self.showMode == DialogShowMode.Gray then
            self.graySkipBtn:SetActive(true)
        elseif self.showMode == DialogShowMode.Hide then
            self.choose:SetActive(false)
        end
    elseif contentType == ContentType.Dialog then
        self:ShowByMode(self.showMode)
    end
end

-- Dialog三种模式显示
function this.ShowByMode(self, mode)
    if mode == DialogShowMode.Show then
        self.dialog:SetActive(true)

        self.skipBtn:SetActive(true)
        self.logBtn:SetActive(true)
        self.showBtn:SetActive(true)

        self.graySkipBtn:SetActive(false)
        self.grayLogBtn:SetActive(false)
        self.grayShowBtn:SetActive(false)

        self.dialogBox:GetComponent("Image"):DOFade(1, 0)
        self.nameImg:SetActive(not string.IsNullOrEmpty(self.nameText:GetComponent("Text").text))
        self.speaker = ""
        self:ChangeDialogRow(mode)
    elseif mode == DialogShowMode.Gray then
        self.dialog:SetActive(true)

        self.skipBtn:SetActive(false)
        self.logBtn:SetActive(false)
        self.showBtn:SetActive(false)

        self.graySkipBtn:SetActive(true)
        self.grayLogBtn:SetActive(true)
        self.grayShowBtn:SetActive(true)

        self.dialogBox:GetComponent("Image"):DOFade(0, 0)
        self.nameImg:SetActive(false)
        local name = self.nameText:GetComponent("Text").text
        self.speaker = string.IsNullOrEmpty(name) and "" or "<size=48>"..name.."：\n".."</size>"
        self:ChangeDialogRow(mode)
    elseif mode == DialogShowMode.Hide then
        self.dialog:SetActive(false)
        self.skipBtn:SetActive(false)
        self.graySkipBtn:SetActive(false)
    end
    self:ShowSpeedMode(self.speedMode, self.showMode)
end

-- 改变显示内容
function this.ChangeDialogRow(self, mode)
    if self.contentType ~= ContentType.Dialog then
        return
    end

    -- 两种模式显示内容区分
    if self.dialogTxtComponent ~= nil and self.dialogTxtComponent.text ~= nil then
        self.dialogTxtComponent.text = self.speaker..self.dialogTxt
    end

    -- 两种模式显示位置不一样
    local y2 = 135
    if not string.IsNullOrEmpty(self.speaker) then -- 要多显示一行名字
        y2 = y2 + self.heightSpace * self.dialogTxtComponent.lineSpacing
    else
        if not self.nameImg.activeSelf then
            y2 = y2 + 15
        end
    end
    self.dialogTxtComponent.transform:DOLocalMoveY(y2, 0)
end

-- 倍速三种模式显示
function this.ShowSpeedMode(self, speedMode, showMode)
    self.autoBtn:SetActive(false)
    self.speedOneBtn:SetActive(false)
    self.speedTwoBtn:SetActive(false)
    self.grayAutoBtn:SetActive(false)
    self.graySpeedOneBtn:SetActive(false)
    self.graySpeedTwoBtn:SetActive(false)
    if speedMode == SpeedMode.Default then
        if showMode == DialogShowMode.Show then
            self.autoBtn:SetActive(true)
        elseif showMode == DialogShowMode.Gray then
            self.grayAutoBtn:SetActive(true)
        end
    elseif speedMode == SpeedMode.AutoOne then
        if showMode == DialogShowMode.Show then
            self.speedOneBtn:SetActive(true)
        elseif showMode == DialogShowMode.Gray then
            self.graySpeedOneBtn:SetActive(true)
        end
    elseif speedMode == SpeedMode.AutoTwo then
        if showMode == DialogShowMode.Show then
            self.speedTwoBtn:SetActive(true)
        elseif showMode == DialogShowMode.Gray then
            self.graySpeedTwoBtn:SetActive(true)
        end
    end
end

-- 显示标题
function this.ShowTitle(self, chapter, text)
    self.contentType = ContentType.Title
    self:SwitchContent(self.contentType)
    local chapterTxt = LangUtil.BindText(self.titleBg.transform:Find("Image1/Chapter"), FontType.All_Dialog)
    local titleImg = self.titleBg.transform:Find("Image2"):GetComponent("Image")
    local titleTxt = LangUtil.BindText(self.titleBg.transform:Find("Image2/Title"), FontType.All_Dialog)
    chapterTxt:DOFade(1, 0)
    self.titleBg:GetComponent("Image"):DOFade(1, 0)
    self.bg:GetComponent("Image"):DOFade(1, 0)
    titleTxt:DOFade(0, 0)
    
    titleImg:DOFade(0, 0)
    chapterTxt.transform:DOScale(1.5, 0)
    chapterTxt.text = nil
    coroutine.start(function ()
        coroutine.waitforseconds(0.3)
        chapterTxt.text = LangUtil.GetSysLang(64)..chapter..LangUtil.GetSysLang(74)
        chapterTxt.transform:DOScale(1, 2)
        coroutine.waitforseconds(2)
        titleTxt.text = text
        titleTxt:DOFade(1, 2)
        titleImg:DOFade(1, 2)
        coroutine.waitforseconds(2.5)
        self.titleBg:GetComponent("Image"):DOFade(0, 1)
        self.bg:GetComponent("Image"):DOFade(0, 1)
        chapterTxt:DOFade(0, 1)
        titleTxt:DOFade(0, 1)
        titleImg:DOFade(0, 1).onComplete = function()
            Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
        end
    end)
end

-- 显示选择
function this.ChangeChoose(self, chooses, jumps)
    self.contentType = ContentType.Choose
    self:SwitchContent(self.contentType)

    -- log记录
    self.dialogUnitIndex = self.dialogUnitIndex + 1
    self.dialogUnits[self.dialogUnitIndex] = { Type = "Choose", Choose = {} }

    coroutine.start(function ()
        ListChildPool:GetInstance():ClearContent(self.chooseContent)
        if self.choosePosTexts ~= nil and #self.choosePosTexts > 0 then
            table.walk(self.choosePosTexts, function (k, v)
                GameObject.Destroy(v.gameObject)
            end)
        end
        local gameObjects = {}
        for i = 1, #chooses do
            ListChildPool:GetInstance():GetChild("ChooseItem", self.chooseContent, function(go)
                gameObjects[i] = go
                go:GetComponent("Button").interactable = true
                local image = go:GetComponent("Image")
                local choose = LangUtil.BindText(go.transform:Find("NameText"), FontType.All_Dialog) --go.transform:Find("NameText").gameObject:GetComponent("Text")
                image:DOFade(1, 0)
                choose:DOFade(1, 0)
                choose.text = self:AnalysisChooseConfig(chooses[i], choose)

                local unit = { Content = choose.text, Select = false }
                table.insert(self.dialogUnits[self.dialogUnitIndex].Choose, unit)

                UIUtil.AddBtnEvent(go, function ()
                    table.walk(gameObjects, function (k, v)
                        v:GetComponent("Button").interactable = false
                    end)
                    self.contentType = nil
                    unit.Select = true
                    coroutine.start(function ()
                        table.walk(gameObjects, function (k, v)
                            if v ~= go then
                                v:GetComponent("Image"):DOFade(0, 0.5)
                                local nameTxt = v.transform:Find("NameText")
                                nameTxt:GetComponent("Text"):DOFade(0, 0.5)
                                local children = v.transform:Find("NameText"):GetComponentsInChildren(typeof(Transform), true)
                                table.csenu(children, function (val)
                                    if val.name == nameTxt.name then return end
                                    val:GetComponent("Text"):DOFade(0, 0.5).onComplete = GameObject.Destroy(val.gameObject)
                                end)
                            end
                        end)
                        go.transform:DOScale(Vector3.New(1.2, 1.2, 1.2), 0.1)
                        coroutine.waitforseconds(0.2)
                        image:DOFade(0, 1)
                        choose:DOFade(0, 1)
                        local children = choose:GetComponentsInChildren(typeof(Transform), true)
                        table.csenu(children, function (val)
                            if val.name == choose.name then return end
                            val:GetComponent("Text"):DOFade(0, 1).onComplete = GameObject.Destroy(val.gameObject)
                        end)
                        coroutine.waitforseconds(1)
                        Game.Scene:GetComponent("DialogComponent"):JumpNextStep(jumps[i])
                    end)
                end, "Choose")
            end)
        end
    end)
end

-- 选择框的平假字1.找出被标识字的宽度和高度
function this.AnalysisChooseConfig(self, text, chooseTxt)
    self.choosePosTexts = {}

    local str = self:SplitsString(text)

    if self.chooseWordHeight == nil then
        local clone1 = GameObject.Instantiate(self.choosePosText.transform) -- chooseMarkContent choosePosText choosePosMark
        clone1:SetParent(self.choosePosText.transform.parent)
        table.insertto(self.choosePosTexts, {clone1})

        local clone2 = GameObject.Instantiate(self.choosePosText.transform)
        clone2:SetParent(self.choosePosText.transform.parent)
        table.insertto(self.choosePosTexts, {clone2})

        self.txt1 = clone1:GetComponent("Text")
        self.txt1.text = str[1]

        self.txt2 = clone2:GetComponent("Text")
        self.txt2.text = str[1].."\n"..str[1]
    end

    -- 解析出平假名，以及剔除掉多余的配置
    local datas, script = self:SplitMark(str, text)

    -- 找到宽度
    for i = 1, #datas do
        if datas[i].mark ~= nil then
            if not string.IsNullOrEmpty(datas[i].preTxt) then
                local clone = GameObject.Instantiate(self.choosePosText.transform)
                clone:SetParent(self.choosePosText.transform.parent)
                clone:GetComponent("Text").text = datas[i].preTxt
                datas[i].preGo = clone
                table.insertto(self.choosePosTexts, {clone})
            end
            local clone = GameObject.Instantiate(self.choosePosText.transform)
            clone:SetParent(self.choosePosText.transform.parent)
            clone:GetComponent("Text").text = datas[i].dialog
            datas[i].dialogGo = clone
            table.insertto(self.choosePosTexts, {clone})

            local clone2 = GameObject.Instantiate(self.choosePosText.transform)
            clone2:SetParent(self.choosePosText.transform.parent)
            clone2:GetComponent("Text").text = script
            datas[i].allGo = clone2
            table.insertto(self.choosePosTexts, {clone2})
        end
    end

    -- 计算平假名的宽度
    for i = 1, #datas do
        if not string.IsNullOrEmpty(datas[i].mark) then
            local clone = GameObject.Instantiate(self.choosePosMark.transform)
            clone:SetParent(self.choosePosMark.transform.parent)
            clone:GetComponent("Text").text = datas[i].mark
            datas[i].markGo = clone
            table.insertto(self.choosePosTexts, {clone})
        end
    end

    coroutine.start(function ()
        coroutine.waitforframes(1)
        -- 获取有平假名的字的宽度位置
        if self.chooseWordHeight == nil then
            self.chooseWordHeight = self.txt1:GetComponent("RectTransform").sizeDelta.y
            local chooseWordHeight2 = self.txt2:GetComponent("RectTransform").sizeDelta.y
            self.chooseHeightSpace = chooseWordHeight2 - self.chooseWordHeight * 2
        end

        for i = 1, #datas do
            if datas[i].mark ~= nil then
                datas[i].startX = datas[i].preGo == nil and 0 or datas[i].preGo:GetComponent("RectTransform").sizeDelta.x
                datas[i].endX = datas[i].startX + datas[i].dialogGo:GetComponent("RectTransform").sizeDelta.x
                datas[i].allX = datas[i].allGo:GetComponent("RectTransform").sizeDelta.x
            end
        end

        for i = 1, #datas do
            if not string.IsNullOrEmpty(datas[i].mark) then
                datas[i].width = datas[i].markGo:GetComponent("RectTransform").sizeDelta.x
            end
        end

        for i = 1, #datas do
            if not string.IsNullOrEmpty(datas[i].mark) then
                local clone = GameObject.Instantiate(self.markItem)
                clone.transform:SetParent(chooseTxt.transform)
                clone:GetComponent("Text").text = datas[i].mark
                local deltaX = (datas[i].allX - datas[i].startX - datas[i].endX + datas[i].width) / 2
                local deltaY = self.chooseWordHeight / 2 + 20
                clone.transform:DOScale(1, 0)
                clone.transform:DOLocalMove(Vector3.New(-deltaX, deltaY, 0), 0)
            end
        end
    end)
    return script
end

-- 显示对话
function this.ChangeDialog(self, name, text, imgPath)
    self.cursor:SetActive(false)
    name = string.gsub(name,"{Name}", Game.Scene.Player.Nickname)
    LangUtil.BindText(self.nameText:GetComponent("Text"), FontType.All_Dialog).text = name
    text = string.gsub(text,"{Name}", Game.Scene.Player.Nickname)

    -- 有图片和没图片有区别
    local exsitImg = not string.IsNullOrEmpty(imgPath)
    self.rowLimit = exsitImg and 29 or 32
    self.dialogTxtComponent = exsitImg and LangUtil.BindText(self.dialogTextImg, FontType.All_Dialog) or
                                           LangUtil.BindText(self.dialogText, FontType.All_Dialog)

    text = self:AnalysisConfig(text)

    -- log记录
    self.dialogUnitIndex = self.dialogUnitIndex + 1
    self.dialogUnits[self.dialogUnitIndex] = { Type = "Dialog", Name = name, Dialog = text }

    -- 打印文字相关
    local dialog = self:LimitWord(text)
    self.dialogScript = self:SplitsString(dialog)
    self.row = #string.split(dialog, "\n")

    self.dialogIndex = 0
    self.dialogTime = Time.time

    self.playEnd = false
    self.dialogEnd = false

    self.dialogText:SetActive(not exsitImg)
    self.dialogTextImg:SetActive(exsitImg)
    self.dialogPicture:SetActive(exsitImg)
    self.dialogTxtComponent.fontSize = 48
    self.dialogTxtComponent.text = ""
    self.dialogTxt = ""

    -- 切换剧情显示
    self.contentType = ContentType.Dialog
    self:SwitchContent(self.contentType)

    -- 对话框
    self.dialogBox.transform:DOKill()
    self.dialogBox.transform:DOLocalMove(Vector3.New(0, -515, 0), 0)
    coroutine.start(function ()
        self.dialogPicture:GetComponent("Image").sprite = exsitImg and (self.faces[imgPath] or AtlasManager:GetInstance():CoLoadImageAsync(imgPath)) or nil
    end)
end

-- 每帧更新
function this.DialogUpdate(self)
    if self:OnFingerClick() then
        local dialog_component = Game.Scene:GetComponent("DialogComponent")
        if dialog_component.waitForClick and dialog_component.waitForClick < 0 then
            dialog_component.waitForClick = dialog_component.waitForClick + 1
            if dialog_component.waitForClick >= 0 then
                dialog_component.waitForClick = 0
                dialog_component:PlayNextStep()
            end
        else
            if self.isLog then
                self.isLog = false
                self.log:SetActive(false)
            end
            if not self.isLog then
                self:OnContentShow()
            end
        end
    end

    --if self:OnFingerSliderDown() then
    --    if not self.isLog then
    --        self:OnContentHide()
    --    end
    --end

    self:ConstantClick()
end

function this.OnFingerClick(self)
    if Input.GetMouseButtonDown(0) then
        startPos = Input.mousePosition
        clickTime = clickMaxTime
    end
    clickTime = clickTime - Time.deltaTime
    if clickTime <= 0 then
        startPos = Vector3.New(-999, -999, -999)
    end
    return Input.GetMouseButtonUp(0) and Vector3.Distance(Input.mousePosition, startPos) < sliderMinDis
end

function this.OnFingerSliderDown(self)
    if Input.GetMouseButtonDown(0) then
        startY = Input.mousePosition.y
        isClicked = true
    end
    if Input.GetMouseButtonUp(0) then
        isClicked = false
    end
    return isClicked and startY - Input.mousePosition.y >= sliderMinDis
end

function this.ConstantClick(self)
    if Input.GetMouseButtonDown(0) then
        clicked = true
        clickedTime = Time.time
        frame = 0
    end
    if Input.GetMouseButtonUp(0) then
        clicked = false
    end
    if clicked and Time.time - clickedTime > 1 then
        frame = frame + 1
        if frame % 3 == 0 and not self.isLog then
            self:OnDialogBoxClick()
        end
    else
        self:UpdateDialog()
    end
end

-- 检测是否更新对话，结束对话，自动切换下一步
function this.UpdateDialog(self)
    if self.contentType ~= ContentType.Dialog then
        return
    end

    if self.playEnd then
        if self.dialogEnd or Time.time - self.dialogTime > self.endDelay / self:GetSpeed() then
            self.dialogTime = Time.time
            self:DialogToNextStep()
        end
        return
    end

    if self.dialogIndex >= #self.dialogScript then
        self:DialogEnd()
        return
    end

    if Time.time - self.dialogTime > self.wordDelay / self:GetSpeed() then
        self.dialogTime = Time.time
        self:RefreshDialog()
    end
end

-- 更新对话显示
function this.RefreshDialog(self)
    if self.dialogTxtComponent == nil then
        return
    end

    self.dialogIndex = self.dialogIndex + 1
    if self.dialogIndex > #self.dialogScript then
        self.dialogIndex = #self.dialogScript
    end

    self.dialogTxt = ""
    for i = 1, self.dialogIndex do
        self.dialogTxt = self.dialogTxt..self.dialogScript[i]
        if self.dialogScript[i] == "\n" then -- 换行，平假名位置也要变
            self:UpdateMarkContentPos()
        end
    end
    self.dialogTxtComponent.text = self.speaker..self.dialogTxt
    self:RefreshMark()
end

-- 限制文字字数
function this.LimitWord(self, script)
    local str = ""
    local splits = string.split(script, "\n")
    for i = 1, #splits do
        local dialog = ""
        local arr = self:SplitsString(splits[i])
        local index = 0
        for k, v in ipairs(arr) do
            dialog = dialog..v
            index = index + 1
            if index % self.rowLimit == 0 then
                dialog = dialog.."\n"
            end
        end
        str = str..dialog
        if i ~= #splits then
            str = str.."\n"
        end
    end
    return str
end

-- 获取字符串长度，包括中英文
function this.SplitsString(self, str)
    local lenInByte = #str
    local arr = {}
    local index = 0
    for i = 1, lenInByte do
        local curByte = string.byte(str, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
            index = index + 1
            arr[index] = string.sub(str, i, i + byteCount - 1)
        elseif curByte >= 192 and curByte <= 223 then
            byteCount = 2
            index = index + 1
            arr[index] = string.sub(str, i, i + byteCount - 1)
        elseif curByte >= 224 and curByte <= 239 then -- utf-8 汉字 3个字节
            byteCount = 3
            index = index + 1
            arr[index] = string.sub(str, i, i + byteCount - 1)
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
            index = index + 1
            arr[index] = string.sub(str, i, i + byteCount - 1)
        end
    end
    return arr
end

-- 解析配置
function this.AnalysisConfig(self, text)
    -- 计算字的高度  间隔的高度
    if self.posTexts ~= nil and #self.posTexts > 0 then
        table.walk(self.posTexts, function (k, v)
            GameObject.Destroy(v.gameObject)
        end)
    end

    self.posTexts = {}
    
    local str = self:SplitsString(self:LimitWord(text))

    local spacing = 0.8
    self.dialogTxtComponent.lineSpacing = spacing
    
    local txt1 = nil
    local txt2 = nil
    if self.wordHeight == nil then
        local clone1 = GameObject.Instantiate(self.posText.transform)
        clone1:SetParent(self.posText.transform.parent)
        table.insertto(self.posTexts, {clone1})

        local clone2 = GameObject.Instantiate(self.posText.transform)
        clone2:SetParent(self.posText.transform.parent)
        table.insertto(self.posTexts, {clone2})

        txt1 = clone1:GetComponent("Text")
        txt1.text = str[1]
        txt1.lineSpacing = spacing

        txt2 = clone2:GetComponent("Text")
        txt2.text = str[1].."\n"..str[1]
        txt2.lineSpacing = spacing
    end

    -- 解析出平假名，以及剔除掉多余的配置
    local datas, script = self:SplitMark(str, text)
    
    if not table.any(datas, function (v) return not string.IsNullOrEmpty(v.mark) end) then
        self.dialogTxtComponent.lineSpacing = 0.75
    end

    -- 找到宽度
    for i = 1, #datas do
        if not string.IsNullOrEmpty(datas[i].mark) then
            if not string.IsNullOrEmpty(datas[i].preTxt) then
                local clone = GameObject.Instantiate(self.posText.transform)
                clone:SetParent(self.posText.transform.parent)
                clone:GetComponent("Text").text = datas[i].preTxt
                datas[i].preGo = clone
                table.insertto(self.posTexts, {clone})
            end
            local clone = GameObject.Instantiate(self.posText.transform)
            clone:SetParent(self.posText.transform.parent)
            clone:GetComponent("Text").text = datas[i].dialog
            datas[i].dialogGo = clone
            table.insertto(self.posTexts, {clone})
        end
    end

    -- 计算平假名的宽度
    for i = 1, #datas do
        if not string.IsNullOrEmpty(datas[i].mark) then
            local clone = GameObject.Instantiate(self.posMark.transform)
            clone:SetParent(self.posMark.transform.parent)
            clone:GetComponent("Text").text = datas[i].mark
            datas[i].markGo = clone
            table.insertto(self.posTexts, {clone})
        end
    end

    coroutine.start(function ()
        coroutine.waitforframes(1)
        -- 获取有平假名的字的宽度位置
        if self.wordHeight == nil then
            self.wordHeight = txt1:GetComponent("RectTransform").sizeDelta.y
            local wordHeight2 = txt2:GetComponent("RectTransform").sizeDelta.y
            self.heightSpace = wordHeight2 - self.wordHeight * 2
        end

        for i = 1, #datas do
            if datas[i].mark ~= nil then
                datas[i].startX = datas[i].preGo == nil and 0 or datas[i].preGo:GetComponent("RectTransform").sizeDelta.x
                datas[i].endX = datas[i].startX + datas[i].dialogGo:GetComponent("RectTransform").sizeDelta.x
            end
        end

        for i = 1, #datas do
            if not string.IsNullOrEmpty(datas[i].mark) then
                datas[i].width = datas[i].markGo:GetComponent("RectTransform").sizeDelta.x
            end
        end

        self.datas = datas
        self:InitMark()
    end)
    return script
end

-- 找出所有平假名并返回剔除平假名和标识符号的字符串
function this.SplitMark(self, str, text)
    local starts = {}
    local ends = {}
    local index = 1
    for i = 1, #str do
        if str[i] == "<" then
            starts[index] = i
        elseif str[i] == ">" then
            ends[index] = i
            index = index + 1
        end
    end
    if #starts ~= #ends then
        Logger.LogError("--平假名配置有问题")
        return
    end
    for i = 1, #starts do
        if starts[i] >= ends[i] then
            Logger.LogError("--平假名配置有问题")
            return
        end
    end

    -- 截取所有字符串
    local sub = {}
    local splits = string.split(text, "<")
    local subIndex = 1
    for i = 1, #splits do
        if not string.IsNullOrEmpty(splits[i]) then
            local subSplits = string.split(splits[i], ">")
            for j = 1, #subSplits do
                if not string.IsNullOrEmpty(subSplits[j]) then
                    sub[subIndex] = subSplits[j]
                    subIndex = subIndex + 1
                end
            end
        end
    end

    -- 解析平假名
    local datas = {}
    local length = 0
    local script = ""
    for i = 1, #sub do
        local subSplits = string.split(sub[i], "^")
        local data = {dialog = nil, mark = nil, startIndex = nil, startX = nil, endX = nil, row = nil}
        length = length + (datas[i - 1] == nil and 0 or #self:SplitsString(datas[i - 1].dialog))
        data.dialog = subSplits[1]
        if #subSplits > 1 then
            data.mark = subSplits[2]
            data.startIndex = length + 1
            data.markSplits = self:SplitsString(data.mark)
        end
        datas[i] = data
        script = script..data.dialog
    end

    local row = 1
    for i = 1, #datas do
        datas[i].splits = string.split(datas[i].dialog, "\n")
        if datas[i].mark ~= nil then
            datas[i].row = row
        end
        row = row + #datas[i].splits - 1
        local preTxt = ""
        for j = i - 1, 1, -1 do
            if #datas[j].splits == 1 then
                preTxt = preTxt..datas[j].splits[1]
            else
                preTxt = preTxt..datas[j].splits[#datas[j].splits]
                break
            end
        end
        if datas[i].mark ~= nil then
            datas[i].preTxt = preTxt
        end
    end

    return datas, script
end

-- 显示片假名(跟要显示的文字一起显示)
function this.RefreshMark(self)
    if self.datas == nil then
        return
    end
    for i = 1, #self.datas do
        if not string.IsNullOrEmpty(self.datas[i].mark) and self.datas[i].text ~= nil then
            self.datas[i].text.text = ""
        end
    end
    for i = 1, #self.datas do
        if not string.IsNullOrEmpty(self.datas[i].mark) and self.datas[i].text ~= nil then
            if self.playEnd then
                for j = 1, #self.datas[i].markSplits do
                    self.datas[i].text.text = self.datas[i].text.text..self.datas[i].markSplits[j]
                end
            else
                if self.dialogIndex >= self.datas[i].startIndex then
                    for j = 1, #self.datas[i].markSplits do
                        if j <= self.dialogIndex - self.datas[i].startIndex + 1 then
                            self.datas[i].text.text = self.datas[i].text.text..self.datas[i].markSplits[j]
                        end
                    end
                end
            end
        end
    end
end

-- 片假名位置，不固定
function this.InitMark(self)
    local rectTnf = self.dialogTxtComponent:GetComponent("RectTransform")
    -- 平假名父节点给个初始位置
    local leftCenterPos = rectTnf.anchoredPosition + Vector2.New(-rectTnf.sizeDelta.x / 2, 0)
    self.markContent.transform.anchoredPosition = leftCenterPos + Vector2.New(0, self.wordHeight / 2)
    -- 父节点根据对话有没有插入人名移动相应位置
    local space = (string.IsNullOrEmpty(self.speaker) and 0 or 1) * self.heightSpace * self.dialogTxtComponent.lineSpacing
    self.markContent.transform.anchoredPosition = self.markContent.transform.anchoredPosition - Vector2.New(0, space)
    
    local showRow = 1 -- 初始化的位置以只有一行为准；每多显示一行，平假名向上移动(self.wordHeight + self.heightSpace)/2
    local height = (showRow - 1) * (self.wordHeight + self.heightSpace) / 2
    coroutine.start(function ()
        for i = 1, #self.datas do
            if not string.IsNullOrEmpty(self.datas[i].mark) then 
                ListChildPool:GetInstance():GetChild("MarkItem", self.markContent, function(go)
                    self.datas[i].gameObject = go
                    self.datas[i].text = LangUtil.BindText(go, FontType.All_Dialog)
                    self.datas[i].text.text = ""
                    local deltaX = (self.datas[i].endX + self.datas[i].startX) / 2
                    local deltaY = (self.datas[i].row - 1) * (self.wordHeight + self.heightSpace) + self.wordHeight / 2
                    self.datas[i].gameObject.transform.anchoredPosition = Vector2.New(deltaX - self.datas[i].width / 2, -deltaY + self.wordHeight / 2 + height + 15)
                end)
            end
        end
    end)
end

---- 有名字和没名字不一样（有名字的话要把名字排除在外）
function this.UpdateMarkContentPos(self)
    local showRow = 1
    for i = 1, table.count(self.dialogScript) do
        if self.dialogIndex >= i and self.dialogScript[i] == "\n" then
            showRow = showRow + 1
        end
    end
    local height = (showRow - 1) * (self.wordHeight + self.heightSpace) / 2
    for i = 1, #self.datas do
        if not string.IsNullOrEmpty(self.datas[i].mark) then --每多显示一行，平假名向上移动(self.wordHeight + self.heightSpace)/2
            local deltaX = (self.datas[i].endX + self.datas[i].startX) / 2
            local deltaY = (self.datas[i].row - 1) * (self.wordHeight + self.heightSpace) + self.wordHeight / 2
            self.datas[i].gameObject.transform.anchoredPosition = Vector2.New(deltaX - self.datas[i].width / 2, -deltaY + self.wordHeight / 2 + height + 15)
        end
    end
end

-- 对话结束
function this.DialogEnd(self)
    self.playEnd = true

    -- 全部显示
    self.dialogIndex = #self.dialogScript
    self:RefreshDialog()
    self:UpdateMarkContentPos()
    
    -- 显示光标
    self.cursor:SetActive(true)
    self.cursor.transform:DOLocalMoveY(116, 0)
    self.cursor.transform:DOLocalMoveY(66, 0.5):SetLoops(-1, LoopType.Yoyo)
end

-- 对话结束切换到下一步
function this.DialogToNextStep(self)
    self.dialogEnd = true
    if self.speedMode ~= SpeedMode.Default then
        self.dialogEnd = false
        self.contentType = nil
        ListChildPool:GetInstance():ClearContent(self.markContent)
        Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
    end
end

-- 点击对话框
function this.OnDialogBoxClick(self)
    if self.contentType ~= ContentType.Dialog or self.showMode == DialogShowMode.Hide then
        return
    end
    if not self.playEnd then
        self:DialogEnd()
    else
        self.dialogEnd = false
        self.contentType = nil
        ListChildPool:GetInstance():ClearContent(self.markContent)
        Game.Scene:GetComponent("DialogComponent"):PlayNextStep()
    end
end

-- 自动播放
function this.OnAutoBtnClick(self)
    self.speedMode = SpeedMode.AutoOne
    self:ShowSpeedMode(self.speedMode, self.showMode)
end

-- 点击倍速1
function this.OnSpeedOneBtnClick(self)
    self.speedMode = SpeedMode.AutoTwo
    self:ShowSpeedMode(self.speedMode, self.showMode)
end

-- 点击倍速2
function this.OnSpeedTwoBtnClick(self)
    self.speedMode = SpeedMode.Default
    self:ShowSpeedMode(self.speedMode, self.showMode)
end

-- 获取速度
function this.GetSpeed(self)
    return self.speedMode == SpeedMode.AutoTwo and 2 or 1
end

-- 点击日志
function this.OnLogBtnClick(self)
    coroutine.start(function ()
        coroutine.waitforendofframe()
        self.isLog = true
        self.log:SetActive(true)
        local text = self.logTxt:GetComponent("Text")
        local t = "\n"
        for i = 1, #self.dialogUnits do
            if self.dialogUnits[i].Type == "Dialog" then
                if string.IsNullOrEmpty(self.dialogUnits[i].Name) then
                    t = t..""..self.dialogUnits[i].Dialog.."\n\n"
                else
                    t = t..self.dialogUnits[i].Name.."：\n"..self.dialogUnits[i].Dialog.."\n\n"
                end
            elseif self.dialogUnits[i].Type == "Choose" then
                for index = 1, #self.dialogUnits[i].Choose do
                    if self.dialogUnits[i].Choose[index].Select then
                        t = t.."<color=#FF0000>「"..self.dialogUnits[i].Choose[index].Content.."」</color>\n"
                    else
                        t = t.."「"..self.dialogUnits[i].Choose[index].Content.."」\n"
                    end
                end
                t = t.."\n"
            end
        end
        text.text = t
        coroutine.start(function ()
            coroutine.waitforendofframe()
            self.logBar.value = 0
        end)
    end)
end

---- 向下滑动隐藏
--function this.OnContentHide(self)
--    if self.contentType == nil or self.contentType == ContentType.Title then
--        return
--    end
--    if self.showMode == DialogShowMode.Hide then
--        return
--    end
--    self.lastShowMode = self.showMode
--    self.showMode = DialogShowMode.Hide
--    self:SwitchContent(self.contentType)
--end

-- 隐藏后显示
function this.OnContentShow(self)
    if self.contentType == nil or self.contentType == ContentType.Title then
        return
    end
    if self.showMode ~= DialogShowMode.Hide then
        return
    end
    self.showMode = DialogShowMode.Show
    --if self.lastShowMode == DialogShowMode.Show then
    --    self.showMode = DialogShowMode.Show
    --elseif self.lastShowMode == DialogShowMode.Gray then
    --    self.showMode = DialogShowMode.Gray
    --end
    --self.lastShowMode = DialogShowMode.Hide
    self:SwitchContent(self.contentType)
end

-- 显示按钮点击事件
function this.OnShowBtnClick(self)
    --self.lastShowMode = DialogShowMode.Show
    self.showMode = DialogShowMode.Gray
    self:ShowByMode(self.showMode)
end

-- 灰色显示按钮点击事件
function this.OnGrayShowBtnClick(self)
    coroutine.start(function () 
        coroutine.waitforendofframe()
        --self.lastShowMode = DialogShowMode.Gray
        self.showMode = DialogShowMode.Hide
        self:ShowByMode(self.showMode)
    end)
end

function this.FontSize(self, size)
    if self.dialogTxtComponent ~= nil then
        self.dialogTxtComponent.fontSize = size
    end
end

function this.DialogShake(self, strength, duration)
    duration = duration or 1
    strength = strength or 100
    self.dialogBox.transform:DOShakePosition(tonumber(duration), tonumber(strength))
end

function this.DialogPictureGreen(self)
    self.dialogPicture:GetComponent("Image").color = Color.New(110 / 255, 255 / 255, 110 / 255, 255 / 255)
end

function this.DialogPictureRemoveColor(self)
    self.dialogPicture:GetComponent("Image").color = Color.New(255 / 255, 255 / 255, 255 / 255, 255 / 255)
end

return this