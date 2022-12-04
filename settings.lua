dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.
dofile("data/scripts/lib/utilities.lua")
local mod_id = "Copis_gun"
mod_settings_version = 1

mod_settings =
{
    {
        ui_fn = mod_setting_vertical_spacing,
        not_setting = true,
        hidden = false,
    },
}
function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end
CurrentLanguage = GameTextGetTranslatedOrNot("$current_language")
Translations = {--Translations or {
    ["searchbar"] = {
        ["English"] = "Search: ",
        ["Deutsch"] = "Suche: ",
    },
    ["spawnchance"] = {
        ["English"] = "Probability: ",
        ["Deutsch"] = "Warscheinlichkeit: ",
    },
    ["spellprobabilities"] = {
        ["English"] = "Spell Probabilities",
        ["Deutsch"] = "Zauber Warscheinlichkeiten",
    },
    ["flaskprobabilities"] = {
        ["English"] = "Flask Probabilities" ,
        ["Deutsch"] = "Trank Warscheinlichkeiten",
    },
    ["wandstatstab"] = {
        ["English"] = "Wand Stats" ,
        ["Deutsch"] = "Zauberstab Werte",
    },
    ["spelltab"] = {
        ["English"] = "Spells" ,
        ["Deutsch"] = "Zauber",
    },
    ["potiontab"] = {
        ["English"] = "Flasks" ,
        ["Deutsch"] = "Tränke",
    },
    ["creditstab"] = {
        ["English"] = "Credits",
        ["Deutsch"] = "Mitwirkende",
    },
    ["helpers"] = {
        ["English"] = "Helpers",
        ["Deutsch"] = "Helfer",
    },
    ["wandstats"] = {
        ["English"] = "Wand Stats",
        ["Deutsch"] = "Zauberstab Werte",
    },
    ["actionid"] = {
        ["English"] = "Action ID:",
        ["Deutsch"] = "Zauber ID:",
    },
    ["minimum"] = {
        ["English"] = "Min",
        ["Deutsch"] = "Min",
    },
    ["maximum"] = {
        ["English"] = "Max",
        ["Deutsch"] = "Max",
    },
    ["spellspercast"] = {
        ["English"] = "Spells Per Cast",
        ["Deutsch"] = "Zauber/Beschwörung",
    },
    ["manacapacity"] = {
        ["English"] = "Mana Capacity",
        ["Deutsch"] = "Mana Kapazität",
    },
    ["manacharge"] = {
        ["English"] = "Mana Charge Speed",
        ["Deutsch"] = "Mana-Lade-Geschwindigkeit",
    },
    ["spread"] = {
        ["English"] = "Spread Degrees",
        ["Deutsch"] = "Streuung",
    },
    ["castdelay"] = {
        ["English"] = "Cast Delay",
        ["Deutsch"] = "Zauberverzögerung",
    },
    ["reloadtime"] = {
        ["English"] = "Reload Time",
        ["Deutsch"] = "Nachladezeit",
    },
    ["slots"] = {
        ["English"] = "Wand Capacity",
        ["Deutsch"] = "Zauberstabkapazität",
    },
    ["spellcount"] = {
        ["English"] = "Generated Spells",
        ["Deutsch"] = "Generierte Zauber",
    },
    ["englishtranslations"] = {
        ["English"] = "English Translations, Settings menu, Mod Contents.",
        ["Deutsch"] = "???",
    },
    ["germantranslations"] = {
        ["English"] = "German Translations, Help with GUIs.",
        ["Deutsch"] = "???",
    },
}

Credits = {--Credits or {
    ["Copi"] = Translations["englishtranslations"][CurrentLanguage],
    ["Horscht"] = Translations["germantranslations"][CurrentLanguage],
}

Wands = {--Wands or {
    {
        name = "handgun",
        sprite = "data/items_gfx/handgun.png",
        defaults = {
            false,      -- Shuffle
            {2,3},      -- Capacity
            {1,1},      -- Spell/Cast
            {1,3},      -- Generated Spells
            {20,28},    -- Reload Time
            {9,15},     -- Cast Delay
            {0,0},      -- Spread Deg
            {25,40},    -- Mana Charge
            {80,130},   -- Mana Max
            "Wand"      -- Name
        }
    },
    {
        name = "bomb_wand",
        sprite = "data/items_gfx/bomb_wand.png",
        defaults = {}
    },
}

Stats = {
    "slots",
    "spellspercast",
    "spellcount",
    "reloadtime",
    "castdelay",
    "spread",
    "manacharge",
    "manacapacity",
}


Tabs = {--Tabs or {
    {
        name = Translations["spelltab"][CurrentLanguage],
        ui_fn = function (gui, new_id, height)
        GuiBeginAutoBox(gui)
                GuiText(gui, 0, 0, Translations["spellprobabilities"][CurrentLanguage] )

                GuiLayoutBeginHorizontal(gui, 2, 0, false, 0, 0)
                    GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                    GuiText(gui, 0, 0, Translations["searchbar"][CurrentLanguage])
                    local query = tostring(ModSettingGetNextValue("copis_cyol.query")) or ""
                    local query_new = GuiTextInput( gui, new_id(), 0, 0, query, 200, 100)
                    if query ~= query_new then
                        ModSettingSetNextValue( "copis_cyol.query", query_new, false )
                    end
                GuiLayoutEnd(gui)

            GuiZSetForNextWidget(gui, 5)
            GuiEndAutoBoxNinePiece(gui, 0, 275, 0, false, 0)
            GuiLayoutAddVerticalSpacing(gui, 2)

            dofile_once("mods/copis_cyol/actions.lua")
            for index, action in ipairs(Actions) do
                if GameTextGetTranslatedOrNot( action.name ):upper():match(query:upper()) then
                    GuiBeginAutoBox(gui)
                    height = height + 39
                    GuiLayoutBeginHorizontal(gui, 2, 1, false, 0, 0)
                        GuiImage(gui, new_id(), 0, 0, action.sprite, 1, 2, 2)
                        GuiTooltip(gui, Translations["actionid"][CurrentLanguage], action.id)
                        GuiLayoutBeginVertical(gui, 1, 0, false, 0, 0)
                            GuiText(gui, 0, 0, GameTextGetTranslatedOrNot( action.name ) )
                            GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                            GuiText(gui, 0, 0, GameTextGetTranslatedOrNot( action.description ) )
                            GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                            local value = ModSettingGetNextValue( ("%s.spawn_prob_%s"):format(mod_id, action.id) )
                            local value_new = GuiSlider( gui, new_id(), 0, 0, Translations["spawnchance"][CurrentLanguage], value, 0, 100, action.defaultprob, 1, "", 100 )
                            if value ~= value_new then
                                ModSettingSetNextValue( ("%s.spawn_prob_%s"):format(mod_id, action.id), value_new, false )
                            end
                            GuiLayoutEnd(gui)
                    GuiLayoutEnd(gui)
                    GuiLayoutAddVerticalSpacing(gui, 28)
                    GuiZSetForNextWidget(gui, 5)
                    GuiEndAutoBoxNinePiece(gui, 0, 250, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png", "data/ui_gfx/decorations/9piece0.png")
                end
            end
        return height
        end,
    },
    {
        name = Translations["wandstatstab"][CurrentLanguage],
        ui_fn = function (gui, new_id, height)
            GuiBeginAutoBox(gui)

            GuiText(gui, 0, 0, Translations["wandstats"][CurrentLanguage] )
            GuiText(gui, 0, 0, " ")
            GuiZSetForNextWidget(gui, 5)
            GuiEndAutoBoxNinePiece(gui, 0, 275, 0, false, 0)
            GuiLayoutAddVerticalSpacing(gui, 2)
            for _, Wand in ipairs(Wands) do
                GuiLayoutBeginVertical(gui, 2, 1, false, 0, 0)
                    GuiBeginAutoBox(gui)
                        GuiLayoutBeginVertical(gui, 0, 0, false, 0, 0)
                            GuiImage(gui, new_id(), 0, 0, Wand.sprite, 1, 2, 2)
                            GuiText(gui, 0, 0, Wand.name)
                            GuiLayoutBeginVertical(gui, 0, 0, false, 0, 0)
                                for _, stat in ipairs(Stats) do
                                    GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                                    local valuemin = ModSettingGetNextValue( ("%s.%s_stat_%s_min"):format(mod_id, Wand.name, stat) )
                                    GuiOptionsAddForNextWidget( gui, 17 )
                                    local valuemin_new = GuiSlider( gui, new_id(), 250, 0, ("%s %s"):format(Translations["minimum"][CurrentLanguage], Translations[stat][CurrentLanguage]), valuemin, 0, 100, 0, 1, "", 100 )
                                    if valuemin ~= valuemin_new then
                                        ModSettingSetNextValue( ("%s.%s_stat_%s_min"):format(mod_id, Wand.name, stat), valuemin_new, false )
                                    end
                                    GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                                    local valuemax = ModSettingGetNextValue( ("%s.%s_stat_%s_max"):format(mod_id, Wand.name, stat) )
                                    GuiOptionsAddForNextWidget( gui, 17 )
                                    local valuemax_new = GuiSlider( gui, new_id(), 250, 0, ("%s %s"):format(Translations["maximum"][CurrentLanguage], Translations[stat][CurrentLanguage]), valuemax, 0, 100, 0, 1, "", 100 )
                                    if valuemax ~= valuemax_new then
                                        ModSettingSetNextValue( ("%s.%s_stat_%s_max"):format(mod_id, Wand.name, stat), valuemax_new, false )
                                    end
                                    GuiLayoutAddVerticalSpacing(gui, 6)
                                end
                            GuiLayoutEnd(gui)
                            height = height + 224
                        GuiLayoutEnd(gui)
                    GuiZSetForNextWidget(gui, 5)
                    GuiEndAutoBoxNinePiece(gui, 0, 250, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png")
                GuiLayoutEnd(gui)
                GuiLayoutAddVerticalSpacing(gui, 224)
            end
        return height
        end,
    },
    {
        name = Translations["potiontab"][CurrentLanguage],
        ui_fn = function (gui, new_id, height)
        GuiBeginAutoBox(gui)
                GuiText(gui, 0, 0, Translations["flaskprobabilities"][CurrentLanguage] )

                GuiLayoutBeginHorizontal(gui, 2, 0, false, 0, 0)
                    GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                    GuiText(gui, 0, 0, Translations["searchbar"][CurrentLanguage])
                    local query = tostring(ModSettingGetNextValue("copis_cyol.query")) or ""
                    local query_new = GuiTextInput( gui, new_id(), 0, 0, query, 200, 100)
                    if query ~= query_new then
                        ModSettingSetNextValue( "copis_cyol.query", query_new, false )
                    end
                GuiLayoutEnd(gui)

            GuiZSetForNextWidget(gui, 5)
            GuiEndAutoBoxNinePiece(gui, 0, 275, 0, false, 0)
            GuiLayoutAddVerticalSpacing(gui, 2)
        return height
        end,
    },
    {
        name = Translations["creditstab"][CurrentLanguage],
        ui_fn = function (gui, new_id, height)
            GuiBeginAutoBox(gui)

            GuiText(gui, 0, 0, Translations["helpers"][CurrentLanguage] )
            GuiText(gui, 0, 0, " ")
            GuiZSetForNextWidget(gui, 5)
            GuiEndAutoBoxNinePiece(gui, 0, 275, 0, false, 0)
            GuiLayoutAddVerticalSpacing(gui, 2)
            for index, credit in pairs(Credits) do
                GuiLayoutBeginVertical(gui, 2, 1, false, 0, 0)
                    GuiBeginAutoBox(gui)
                        GuiText(gui, 0, 0, index)
                        GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1.0)
                        GuiText(gui, 0, 0, credit)
                        height = height + 28
                    GuiZSetForNextWidget(gui, 5)
                    GuiEndAutoBoxNinePiece(gui, 0, 250, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png")
                GuiLayoutEnd(gui)
                GuiLayoutAddVerticalSpacing(gui, 18)
            end
        return height
        end,
    },
}

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui(gui, in_main_menu)
    screen_width, screen_height = GuiGetScreenDimensions(gui)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
    GuiLayoutBeginVertical(gui, 0, 0, false, 0, 0)
        id = 420691337
        local function new_id() id = id + 1; return id end
        CurrentTab = CurrentTab or 1
        GuiLayoutBeginVertical(gui, 0, 0, false, 0, 0)
            GuiLayoutBeginHorizontal(gui, 0, 0)
                for index, tab in ipairs(Tabs) do
                    GuiLayoutBeginVertical(gui, 0, 0, false)
                    GuiOptionsAddForNextWidget( gui, 21 )
                    GuiOptionsAddForNextWidget( gui, 28 )
                    local pressed = GuiImageButton(gui, new_id(), -2, 0, "", "data/ui_gfx/decorations/tab.png")
                    if pressed then
                        CurrentTab = index
                    end
                    local td = GuiGetTextDimensions(gui, tab.name )
                    GuiText(gui, td/2, -td/2, tab.name )
                    GuiLayoutEnd(gui)
                    GuiLayoutAddHorizontalSpacing(gui, 1)
                end

            GuiLayoutEnd(gui)
            GuiLayoutAddVerticalSpacing(gui, 1)
            local height = 42
            height = Tabs[CurrentTab].ui_fn(gui, new_id, height)
        GuiLayoutEnd(gui)
    GuiLayoutEnd(gui)
    GuiLayoutAddVerticalSpacing(gui, height)
end
