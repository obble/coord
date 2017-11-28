

    local OnUpdate = function(self, elapsed)
        local width     = WorldMapDetailFrame:GetWidth()
        local height    = WorldMapDetailFrame:GetHeight()
        local mx, my    = WorldMapDetailFrame:GetCenter()
        local scale     = WorldMapDetailFrame:GetEffectiveScale()
        local px, py    = GetPlayerMapPosition'player'
        local player    = _G['modui_xyplayer']
        local cursor    = _G['modui_xycursor']
        local x,  y     = GetCursorPosition()

        mx = ((x / scale) - (mx - width / 2) ) / width
        my = ((my + height / 2) - (y / scale)) / height

        if  mx >= 0 and my >= 0 and mx <= 1 and my <= 1 then
            cursor:SetText('•  Mouse'..format(': %.0f / %.0f', mx*100, my*100))
        else
            cursor:SetText''
        end

        if  px ~= 0 and py ~= 0 then
            player:SetText(PLAYER..format(': %.0f / %.0f', px*100, py*100))
        else
            player:SetText'X / X'
        end
    end

    local OnEvent = function()
        local f = CreateFrame('Frame', 'coordinates', WorldMapButton)

        local player = f:CreateFontString('modui_xyplayer', 'OVERLAY')
        player:SetFont(STANDARD_TEXT_FONT, 18, 'OUTLINE')
        player:SetShadowOffset(0, -0)
        player:SetJustifyH'LEFT'
        player:SetPoint('BOTTOMRIGHT', WorldMapButton, 'BOTTOM', -12, 12)
        player:SetTextColor(1, 1, 1)

        local cursor = f:CreateFontString('modui_xycursor', 'OVERLAY')
        cursor:SetFont(STANDARD_TEXT_FONT, 18, 'OUTLINE')
        cursor:SetShadowOffset(0, -0)
        cursor:SetJustifyH'LEFT'
        cursor:SetPoint('LEFT', player, 'RIGHT', 3, 0)
        cursor:SetTextColor(1, 1, 1)

        f:SetScript('OnUpdate', OnUpdate)
    end

    local e = CreateFrame'Frame'
    e:RegisterEvent'PLAYER_LOGIN'
    e:SetScript('OnEvent', OnEvent)

    --
