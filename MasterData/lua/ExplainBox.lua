local rect = nil
function Awake()
    rect = ComUtil.GetCom(bg,"RectTransform")
end

function OnOpen()
    if data then
        CSAPI.SetText(txtTitle, data.title or LanguageMgr:GetByID(1045))
        CSAPI.SetText(content, data.content or "");
        if (StringUtil:IsEmpty(data.content)) then
            LogError(string.format("Explain error.%s", table.tostring(data, true)));
        end

        local canvasSize = CSAPI.GetMainCanvasSize()
        local offsetX,offsetY = (canvasSize[0] - 1920)/2,(canvasSize[1] - 1080)/2

        local pos = data.pos or {0, 0}
        pos[1] = pos[1] == 0 and 0 or pos[1]
        pos[1] = pos[1] > 0 and pos[1] + offsetX or pos[1]
        pos[1] = pos[1] < 0 and pos[1] - offsetX or pos[1]
        pos[2] = pos[2] == 0 and 0 or pos[2]
        pos[2] = pos[2] > 0 and pos[2] + offsetY or pos[2]
        pos[2] = pos[2] < 0 and pos[2] - offsetY or pos[2]
        CSAPI.SetLocalPos(bg, pos[1], pos[2]) --自适应分辨率变化

        local size = data.size or {662, 392}
        CSAPI.SetRTSize(bg, size[1], size[2])
    end
end

function OnClickClose()
    view:Close()
end
