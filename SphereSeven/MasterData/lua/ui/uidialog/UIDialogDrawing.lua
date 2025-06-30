local this = require "UI.UIDialog.UIDialogView"

function this.OnDrawingEnable(self)
    -- 立绘相关
    self.drawing:SetActive(false)
    self.left_drawing_cur = nil
    self.middle_drawing_cur = nil
    self.right_drawing_cur = nil
    self.assist_drawing_cur = nil
    self.left_face_cur = nil
    self.middle_face_cur = nil
    self.right_face_cur = nil
    self.assist_face_cur = nil
    self.left_face_tnf = nil
    self.middle_face_tnf = nil
    self.right_face_tnf = nil
    self.assist_face_tnf = nil
end

function this.OnDrawingDisable(self)
    self.drawing:SetActive(false)
    if self.doLeftDrawingShake ~= nil then
        self.doLeftDrawingShake:Kill()
        self.doLeftDrawingShake = nil
    end
    if self.doMiddleDrawingShake ~= nil then
        self.doMiddleDrawingShake:Kill()
        self.doMiddleDrawingShake = nil
    end
    if self.doRightDrawingShake ~= nil then
        self.doRightDrawingShake:Kill()
        self.doRightDrawingShake = nil
    end
    if self.doAssistDrawingShake ~= nil then
        self.doAssistDrawingShake:Kill()
        self.doAssistDrawingShake = nil
    end
end

-- 显示立绘
---@param faceNode string @ 和 drawingPath中 图片名称 同名
function this.ShowDrawing(self, drawingType, drawingPath, faceNode, facePath, speakDrawing)
    if not self.drawing.activeSelf then
        self.drawing:SetActive(true)
    end
    -- 初始化
    local drawingGo = self:GetDrawingGo(drawingType)

    -- 没有立绘要显示，直接隐藏就行了
    if string.IsNullOrEmpty(drawingPath) then
        drawingGo:SetActive(false)
        if drawingType == TitleType.LeftDrawing then
            self.left_drawing_cur = nil
            self.left_face_cur = nil
        elseif drawingType == TitleType.MiddleDrawing then
            self.middle_drawing_cur = nil
            self.middle_face_cur = nil
        elseif drawingType == TitleType.RightDrawing then
            self.right_drawing_cur = nil
            self.right_face_cur = nil
        elseif drawingType == TitleType.AssistDrawing then
            self.assist_drawing_cur = nil
            self.assist_face_cur = nil
        end
        return
    end

    -- 立绘的高度，宽度，缩放的微调
    local height = CharacterHeight["Common"] + (CharacterHeight[faceNode] or 0)
    local width = CharacterWidth["Common"] + (CharacterWidth[faceNode] or 0)
    local scale = CharacterScale[faceNode] or CharacterScale["Common"]

    -- 有显示立绘：左中右立绘初始化位置，初始化位置，获取上一次显示的立绘和脸
    local drawing_cur
    local face_cur
    local drawingImg = drawingGo:GetComponent("Image")
    drawingGo:SetActive(true)
    if drawingType == TitleType.LeftDrawing then
        drawingGo.transform.localPosition = Vector3.New(-600 + width, height, 0)
        drawing_cur = self.left_drawing_cur
        face_cur = self.left_face_cur
    elseif drawingType == TitleType.MiddleDrawing then
        drawingGo.transform.localPosition = Vector3.New(width, height, 0)
        drawing_cur = self.middle_drawing_cur
        face_cur = self.middle_face_cur
    elseif drawingType == TitleType.RightDrawing then
        drawingGo.transform.localPosition = Vector3.New(600 + width, height, 0)
        drawing_cur = self.right_drawing_cur
        face_cur = self.right_face_cur
    elseif drawingType == TitleType.AssistDrawing then
        drawingGo.transform.localPosition = Vector3.New(600 + width, height, 0)
        drawing_cur = self.assist_drawing_cur
        face_cur = self.assist_face_cur
    end

    -- 获取脸的Tnf和脸部的image，不想关的表情直接隐藏就好
    local faceTnf = nil
    local faceImg = nil
    local children = drawingGo:GetComponentsInChildren(typeof(Transform), true)
    table.csenu(children, function (val)
        if val.name == drawingGo.name then return end
        val.gameObject:SetActive(false)
        if val.name == faceNode then
            val.gameObject:SetActive(true)
            faceTnf = val
        end
    end)
    if faceTnf ~= nil then
        faceImg = faceTnf:GetComponent("Image")
    else
        -- 该角色没有表情切换，预制体就不需要配置该节点
    end

    -- 更新新的立绘和表情缓存
    if drawingType == TitleType.LeftDrawing then
        self.left_drawing_cur = drawingPath
        self.left_face_cur = facePath
        self.left_face_tnf = faceTnf
    elseif drawingType == TitleType.MiddleDrawing then
        self.middle_drawing_cur = drawingPath
        self.middle_face_cur = facePath
        self.middle_face_tnf = faceTnf
    elseif drawingType == TitleType.RightDrawing then
        self.right_drawing_cur = drawingPath
        self.right_face_cur = facePath
        self.right_face_tnf = faceTnf
    elseif drawingType == TitleType.AssistDrawing then
        self.assist_drawing_cur = drawingPath
        self.assist_face_cur = facePath
        self.assist_face_tnf = faceTnf
    end
    
    -- 1> 脸部要不要显示
    local isShowFace = faceImg ~= nil and not string.IsNullOrEmpty(facePath)
    
    -- 2> 判断该立绘总体是亮还是暗的
    local light = #speakDrawing == 0 or table.any(speakDrawing, function (k) return k == drawingType end)
    local value = light and 1 or 100 / 255

    -- 3> 不需要显示脸部就隐藏
    if not isShowFace then
        if faceImg then 
            faceImg:DOFade(0, 0)
            faceImg.gameObject:SetActive(false)
        end
    end

    -- 4> 终止上一次的dotween，清空材质球
    drawingImg:DOKill()
    drawingImg.material = nil
    if faceImg then 
        faceImg:DOKill()
        faceImg.material = nil
    end
    drawingGo.transform:DOScale(Vector3.New(scale, scale, scale), 0)

    -- 5> 立绘：立绘没有切换。看是否需要换表情就好
    if drawing_cur == drawingPath then
        drawingImg:DOColor(Color.New(value, value, value, 1), 0.5)
        if not isShowFace then return end
        faceImg.sprite = self.faces[facePath]
        faceImg:DOColor(drawingImg.color, 0)
        faceImg:DOColor(Color.New(value, value, value, 1), 0.5)
    else -- 立绘切换了, 表情肯定切换
        drawingImg.sprite = self.drawings[drawingPath]
        drawingImg:SetNativeSize()
        drawingImg:DOColor(Color.New(value, value, value, 0), 0)
        drawingImg:DOFade(1, 0.25)
        if not isShowFace then return end
        faceImg.sprite = self.faces[facePath]
        faceImg:DOColor(Color.New(value, value, value, 0), 0)
        faceImg:DOFade(1, 0.5)
    end
end

function this.GetDrawingGo(self, drawingType)
    local go
    if drawingType == TitleType.LeftDrawing then
        go = self.left_drawing_img
    elseif drawingType == TitleType.MiddleDrawing then
        go = self.middle_drawing_img
    elseif drawingType == TitleType.RightDrawing then
        go = self.right_drawing_img
    elseif drawingType == TitleType.AssistDrawing then
        go = self.assist_drawing_img
    end
    return go
end

function this.DrawingMoveX(self, drawingType, targetPos, duration, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    targetPos = targetPos or 0
    duration = duration or 0.3
    delay = delay or 0
    if tonumber(delay) > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(tonumber(delay))
            drawingGo.transform:DOLocalMoveX(tonumber(targetPos), tonumber(duration))
        end)
    else
        drawingGo.transform:DOLocalMoveX(tonumber(targetPos), tonumber(duration))
    end
end

function this.DrawingMoveY(self, drawingType, targetPos, duration)
    local drawingGo = self:GetDrawingGo(drawingType)
    targetPos = targetPos or 1
    duration = duration or 1
    drawingGo.transform:DOLocalMoveY(tonumber(targetPos), tonumber(duration))
end

function this.DrawingScale(self, drawingType, targetScale, duration)
    local drawingGo = self:GetDrawingGo(drawingType)
    targetScale = targetScale or 1
    duration = duration or 1
    drawingGo.transform:DOScale(tonumber(targetScale), tonumber(duration))
end

function this.DrawingScaleX(self, drawingType, targetScale, duration)
    local drawingGo = self:GetDrawingGo(drawingType)
    targetScale = targetScale or 1
    duration = duration or 1
    drawingGo.transform:DOScaleX(tonumber(targetScale), tonumber(duration))
end

function this.DrawingShake(self, drawingType, strength, duration, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    duration = duration or 1
    strength = strength or 100
    delay = delay or 0
    local func = function(dur, stren)
        local t
        if dur == "loop" then
            t = drawingGo.transform:DOShakePosition(1, tonumber(strength), 10, 90, false, false):SetLoops(-1, LoopType.Incremental)
        else
            dur = dur or 1
            t = drawingGo.transform:DOShakePosition(tonumber(dur), tonumber(stren))
        end
        if drawingType == TitleType.LeftDrawing then
            if self.doLeftDrawingShake ~= nil then
                self.doLeftDrawingShake:Kill()
                self.doLeftDrawingShake = nil
            end
            self.doLeftDrawingShake = t
        elseif drawingType == TitleType.MiddleDrawing then
            if self.doMiddleDrawingShake ~= nil then
                self.doMiddleDrawingShake:Kill()
                self.doMiddleDrawingShake = nil
            end
            self.doMiddleDrawingShake = t
        elseif drawingType == TitleType.RightDrawing then
            if self.doRightDrawingShake ~= nil then
                self.doRightDrawingShake:Kill()
                self.doRightDrawingShake = nil
            end
            self.doRightDrawingShake = t
        elseif drawingType == TitleType.AssistDrawing then
            if self.doAssistDrawingShake ~= nil then
                self.doAssistDrawingShake:Kill()
                self.doAssistDrawingShake = nil
            end
            self.doAssistDrawingShake = t
        end
    end
    if tonumber(delay) > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(tonumber(delay))
            func(duration, strength)
        end)
    else
        func(duration, strength)
    end
end

function this.RemoveDrawingShake(self, drawingType)
    if drawingType == TitleType.LeftDrawing then
        if self.doLeftDrawingShake ~= nil then
            self.doLeftDrawingShake:Kill()
        end
    elseif drawingType == TitleType.MiddleDrawing then
        if self.doMiddleDrawingShake ~= nil then
            self.doMiddleDrawingShake:Kill()
        end
    elseif drawingType == TitleType.RightDrawing then
        if self.doRightDrawingShake ~= nil then
            self.doRightDrawingShake:Kill()
        end
    elseif drawingType == TitleType.AssistDrawing then
        if self.doAssistDrawingShake ~= nil then
            self.doAssistDrawingShake:Kill()
        end
    end
end

function this.SetAsFirstSibling(self, drawingType)
    local drawingGo = self:GetDrawingGo(drawingType)
    drawingGo.transform:SetAsFirstSibling()
end

-- 立绘变灰色
function this.DrawingGrey(self, drawingType)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    drawingGo:GetComponent("Image").material = self.greyMtrl
    if faceTnf ~= nil then
        faceTnf:GetComponent("Image").material = self.greyMtrl
    end
end

-- 石化
function this.DrawingPetrifaction(self, drawingType)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    drawingGo:GetComponent("Image").material = self.petrifactionMtrl
    if faceTnf ~= nil then
        faceTnf:GetComponent("Image").material = self.petrifactionMtrl
    end
end

-- 结冰
function this.DrawingIce(self, drawingType, strength, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    delay = delay or 0
    strength = strength or 1
    delay = tonumber(delay)
    local func = function()
        self.iceMtrl:SetFloat("_StatueDegree", 1)
        self.iceMtrl:SetFloat("_Brightness", tonumber(strength))
        drawingGo:GetComponent("Image").material = self.iceMtrl
        if faceTnf ~= nil then
            faceTnf:GetComponent("Image").material = self.iceMtrl
        end
    end
    if delay > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(delay)
            func()
        end)
    else
        func()
    end
end

-- 材质去除
function this.DrawingRemoveMaterial(self, drawingType, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    delay = delay or 0
    delay = tonumber(delay)
    local func = function()
        drawingGo:GetComponent("Image").material = nil
        if faceTnf ~= nil then
            faceTnf:GetComponent("Image").material = nil
        end
    end
    if delay > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(delay)
            func()
        end)
    else
        func()
    end
end

-- 改变立绘的alpha值
function this.DrawingFade(self, drawingType, strength, duration)
    local drawingGo = self:GetDrawingGo(drawingType)
    duration = duration or 1
    strength = strength or 0
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    local drawingImg = drawingGo:GetComponent("Image")
    drawingImg:DOKill()
    drawingImg:DOFade(1, 0)
    drawingImg:DOFade(tonumber(strength), tonumber(duration))

    if faceTnf ~= nil then
        local faceImg = faceTnf:GetComponent("Image")
        faceImg:DOKill()
        faceImg:DOFade(1, 0)
        local time = tonumber(duration) / 2 -- 避免表情叠加  太亮有破绽
        faceImg:DOFade(tonumber(strength), time)
    end
end

-- 立绘变黑
function this.DrawingBlack(self, drawingType, duration, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    duration = duration or 1
    delay = delay or 0
    local drawingImg = drawingGo:GetComponent("Image")
    delay = tonumber(delay)
    local func = function()
        drawingImg:DOKill()
        drawingImg:DOColor(Color.New(0, 0, 0, drawingImg.color.a), tonumber(duration))
        if faceTnf ~= nil then
            local faceImg = faceTnf:GetComponent("Image")
            faceImg:DOKill()
            faceImg:DOColor(Color.New(0, 0, 0, faceImg.color.a), tonumber(duration))
        end
    end
    if delay > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(delay)
            func()
        end)
    else
        func()
    end
end

-- 立绘变白
function this.DrawingWhite(self, drawingType, duration, delay)
    local drawingGo = self:GetDrawingGo(drawingType)
    local faceTnf
    if drawingType == TitleType.LeftDrawing then
        faceTnf = self.left_face_tnf
    elseif drawingType == TitleType.MiddleDrawing then
        faceTnf = self.middle_face_tnf
    elseif drawingType == TitleType.RightDrawing then
        faceTnf = self.right_face_tnf
    elseif drawingType == TitleType.AssistDrawing then
        faceTnf = self.assist_face_tnf
    end
    duration = duration or 1
    delay = delay or 0
    local drawingImg = drawingGo:GetComponent("Image")
    delay = tonumber(delay)
    local func = function()
        drawingImg:DOKill()
        drawingImg:DOColor(Color.New(1, 1, 1, drawingImg.color.a), tonumber(duration))
        if faceTnf ~= nil then
            local faceImg = faceTnf:GetComponent("Image")
            faceImg:DOKill()
            faceImg:DOColor(Color.New(1, 1, 1, faceImg.color.a), tonumber(duration))
        end
    end
    if delay > 0 then
        coroutine.start(function ()
            coroutine.waitforseconds(delay)
            func()
        end)
    else
        func()
    end
end

return this