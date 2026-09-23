local dotMove1 = nil
local dotMove2 = nil
local dotCanvasG1 = nil
local dotCanvasG2 = nil

function Awake()
    dotMove1 = ComUtil.GetCom(dot1, "ActionMoveByCurve")
    dotMove2 = ComUtil.GetCom(dot2, "ActionMoveByCurve")
    dotCanvasG1 = ComUtil.GetCom(dot1, "CanvasGroup")
    dotCanvasG2 = ComUtil.GetCom(dot2, "CanvasGroup")
end

function Play(_type, _time, _delay, _startPos, _targetPos)
    local dotMove = _type == 1 and dotMove1 or dotMove2
    dotMove.time = _time
    dotMove.delay = _delay
    dotMove:SetStartPos(_startPos.x, _startPos.y, 0)
    dotMove:SetTargetPos(_targetPos.x, _targetPos.y, 0)
    dotMove:Play()
end

function SetColor(color)
    CSAPI.SetImgColor(dot1.gameObject, color[1], color[2], color[3], color[4])
    CSAPI.SetImgColor(dot2.gameObject, color[1], color[2], color[3], color[4])
end

function SetRTSize(w, h)
    CSAPI.SetAnchor(gameObject, 0, 0)
    CSAPI.SetRTSize(gameObject, w, h)
end

