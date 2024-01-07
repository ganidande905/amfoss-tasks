def check_winner(m):
    for i in range (3):
        if m[i][0]==m[i][1]==m[i][2] and m[i][0] != '.':
            return m[i][0]
        if m[0][i]==m[1][i]==m[2][i] and m[0][i] != '.':
            return m[0][i]
        if m[0][0]==m[1][1]==m[2][2] and m[0][0] != '.':
            return m[0][0]
        if m[2][0]==m[1][1]==m[0][2] and m[2][0] != '.':
            return m[2][0]
    return 'DRAW'
t = int(input())
for _ in range(t):
    m = []
    for _ in range(3):
        l = []
        for _ in range(3):
            v = input()
            l.append(v)
        m.append(l)
    print(m)
    winner=check_winner(m)
    print(winner)      
    
