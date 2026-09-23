local plotData =nil
local lastInfo = nil
local info = nil

function Refresh(_data)
    plotData = _data
    info = plotData and plotData:GetTopImgInfo()
    if info then
        SetState()
    end
end

function SetState()
    if info.enter then
        if lastInfo then
            if lastInfo.name ~= info.name then --存在上一个且不是同名
                if tonumber(info.enter) == 2 then
                    PlotTween.Twinkle2(icon,lastInfo.time,info.time,function ()
                        SetIcon()
                        lastInfo = info
                    end,lastInfo.delay,info.delay)
                else                  
                    SetIcon()
                    lastInfo = info
                end
            end
        else
            CSAPI.SetGOActive(icon,true)
            if tonumber(info.enter) == 2 then
                SetIcon()
                PlotTween.FadeIn(icon,info.time,nil,info.delay)
                lastInfo = info
            else
                SetIcon()
                lastInfo = info
            end
        end
    elseif info.out then
        if lastInfo and lastInfo.name == info.name then
            if tonumber(info.out) == 2 then
                PlotTween.FadeOut(icon,info.time,function ()
                    ResetPos()
                    CSAPI.SetGOAlpha(icon,1)
                    CSAPI.SetGOActive(icon,false)
                    lastInfo = nil
                end,info.delay)
            else
                ResetPos()
                CSAPI.SetGOActive(icon,false)
                lastInfo =nil
            end
        else
            LogError("当前上层图片没有可隐藏的图片!!!!" .. info.name)
        end
    elseif info.move then
        if lastInfo and lastInfo.name == info.name then
            PlotTween.TweenMove(icon,info.move,info.time,nil,info.delay)
        else
            LogError("当前上层图片没有可移动的图片!!!!" .. info.name)
        end
    end
end

function SetIcon()
    ResUtil.PlotTop:Load(icon, info.name)
end

function ResetPos()
    CSAPI.SetLocalPos(icon,0,0)
end