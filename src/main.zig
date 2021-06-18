usingnamespace @import("raylib");
usingnamespace @import("raylib-math");

const Game = struct {
    const fps : u8 = 60;
    const width : u16 = 800;
    const height : u16 = 600;
    const min_spd: f32 = 200;
    const max_spd: f32 = 800;

    const Player = struct {
        x: f32 = 0.0,
        y: f32 = Game.height/2,
        width: i32 = 10,
        height: i32 = 80,

        fn update (self:*Player) void {
            var down : i2 = @boolToInt(IsKeyDown(KeyboardKey.KEY_DOWN));
            var up : i2 = @boolToInt(IsKeyDown(KeyboardKey.KEY_UP));
            var speed : f32 = @intToFloat(f32, down - up) * GetFrameTime() * Game.min_spd * 3;
            self.y = Clamp(self.y + speed, 0, Game.height);
        }

        fn draw (self:*Player) void {
            DrawRectangle(
                @floatToInt(i16, self.x),
                @floatToInt(i16, self.y) - self.height,
                self.width,
                self.height * 2,
                WHITE
            );
        }
    };

    const Ball = struct {
        x: f32,
        y: f32,
        hspeed: f32,
        vspeed: f32,
        size: f32 = 8.0,

        fn create () Ball {
            return Ball {
                .x = Game.width/2,
                .y = Game.height/2,
                .hspeed = -Game.min_spd,
                .vspeed = 000.0
            };
        }

        fn update (self:*Ball) void {
            self.x += GetFrameTime() * self.hspeed;
            self.y += GetFrameTime() * self.vspeed;
        }

        fn draw (self:Ball) void {
            DrawCircle(
                @floatToInt(i16, self.x),
                @floatToInt(i16, self.y),
                self.size,
                WHITE
            );
        }
    };

    pub fn app () void {
        InitWindow(Game.width, Game.height, "Pong Game");
        SetTargetFPS(Game.fps);

        var player = Player {};
        var ball = Ball.create();

        var application = Game {
            .player = &player,
            .ball = &ball
        };

        while(!WindowShouldClose()){
            application.update();
            application.draw();
        }

        CloseWindow(); 
    }

    fn update(self:Game) void {
        self.player.update();
        self.ball.update();
    }
    
    fn draw(self:Game) void {
        BeginDrawing();

        ClearBackground(BLACK);
        self.player.draw();
        self.ball.draw();

        EndDrawing();
    }

    player : *Player,
    ball : *Ball,
};

pub fn main() anyerror!void {
    Game.app();
}
